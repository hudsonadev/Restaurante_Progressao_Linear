import sqlite3

CAMINHO_BANCO = "restaurante.db"

def conectar():
    """Abre a conexão com o banco e habilita as chaves estrangeiras."""
    conexao = sqlite3.connect(CAMINHO_BANCO)
    conexao.execute("PRAGMA foreign_keys = ON")
    return conexao

def criar_tabelas():
    """Cria as quatro tabelas do sistema, caso ainda não existam."""
    conexao = conectar()
    cursor = conexao.cursor()

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS mesas (
            id_mesa INTEGER PRIMARY KEY AUTOINCREMENT
        )
    """)

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS pratos (
            id_prato INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            categoria TEXT,
            complexidade INTEGER NOT NULL
                CHECK (complexidade BETWEEN 1 AND 5),
            tempo_base_min REAL NOT NULL
        )
    """)

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS pedidos (
            id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
            id_mesa INTEGER NOT NULL,
            data_hora_pedido TEXT NOT NULL,
            tempo_preparo_minutos REAL NOT NULL,
            FOREIGN KEY (id_mesa)
                REFERENCES mesas (id_mesa)
        )
    """)

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS itens_pedido (
            id_item INTEGER PRIMARY KEY AUTOINCREMENT,
            id_pedido INTEGER NOT NULL,
            id_prato INTEGER NOT NULL,
            quantidade INTEGER NOT NULL CHECK (quantidade > 0),
            FOREIGN KEY (id_pedido)
                REFERENCES pedidos (id_pedido),
            FOREIGN KEY (id_prato)
                REFERENCES pratos (id_prato)
        )
    """)

    conexao.commit()
    conexao.close()

print("Tabelas criadas ou verificadas com sucesso!")
if __name__ == "__main__":
    criar_tabelas()