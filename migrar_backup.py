import re
import sqlite3
from pathlib import Path

ARQUIVO_SQL = Path("backup_banco.sql")
BANCO_NOVO = Path("restaurante_migrado.db")

def migrar():
    if not ARQUIVO_SQL.exists():
        print("Erro: arquivo backup_banco.sql não encontrado.")
        return
    if BANCO_NOVO.exists():
        print("O banco restaurante_migrado.db já existe.")
        print("Não será sobrescrito para evitar perda de dados.")
        return

    conteudo = ARQUIVO_SQL.read_text(encoding="utf-8")

    conexao = sqlite3.connect(BANCO_NOVO)
    cursor = conexao.cursor()

    try:
        cursor.execute("PRAGMA foreign_keys = OFF")

        cursor.executescript("""
            CREATE TABLE mesas (
                id_mesa INTEGER PRIMARY KEY AUTOINCREMENT
            );

            CREATE TABLE pratos (
                id_prato INTEGER PRIMARY KEY AUTOINCREMENT,
                nome TEXT NOT NULL,
                categoria TEXT,
                complexidade INTEGER NOT NULL
                    CHECK (complexidade BETWEEN 1 AND 5),
                tempo_base_min REAL NOT NULL
            );

            CREATE TABLE pedidos (
                id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
                id_mesa INTEGER NOT NULL,
                data_hora_pedido TEXT NOT NULL,
                tempo_preparo_minutos REAL NOT NULL,
                FOREIGN KEY (id_mesa)
                    REFERENCES mesas(id_mesa)
            );

            CREATE TABLE itens_pedido (
                id_item INTEGER PRIMARY KEY AUTOINCREMENT,
                id_pedido INTEGER NOT NULL,
                id_prato INTEGER NOT NULL,
                quantidade INTEGER NOT NULL
                    CHECK (quantidade > 0),
                FOREIGN KEY (id_pedido)
                    REFERENCES pedidos(id_pedido),
                FOREIGN KEY (id_prato)
                    REFERENCES pratos(id_prato)
            );
        """)

        # Extrai os comandos INSERT do backup MySQL.
        comandos = re.findall(
            r"INSERT INTO `(\w+)` VALUES\s*(.*?);",
            conteudo,
            flags=re.DOTALL | re.IGNORECASE
        )

        if not comandos:
            raise ValueError(
                "Nenhum comando INSERT foi encontrado no backup."
            )

        for tabela, valores in comandos:
            if tabela not in {
                "mesas", "pratos", "pedidos", "itens_pedido"
            }:
                continue

            sql = f"INSERT INTO {tabela} VALUES {valores}"
            cursor.execute(sql)

        conexao.commit()

        # Reativa as verificações e confere os relacionamentos.
        cursor.execute("PRAGMA foreign_keys = ON")

        erros = cursor.execute(
            "PRAGMA foreign_key_check"
        ).fetchall()

        if erros:
            raise ValueError(
                f"Foram encontrados problemas nas chaves estrangeiras: "
                f"{erros}"
            )

        print("\nMigração concluída!")

        for tabela in (
            "mesas", "pratos", "pedidos", "itens_pedido"
        ):
            total = cursor.execute(
                f"SELECT COUNT(*) FROM {tabela}"
            ).fetchone()[0]

            print(f"{tabela}: {total} registros")

    except Exception as erro:
        conexao.rollback()
        conexao.close()

        # Remove apenas o banco novo criado por esta execução.
        if BANCO_NOVO.exists():
            BANCO_NOVO.unlink()

        print(f"\nErro na migração: {erro}")
        print("O banco antigo não foi alterado.")
        return

    conexao.close()
    print(f"\nBanco criado: {BANCO_NOVO}")
if __name__ == "__main__":
    migrar()