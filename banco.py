import sqlite3

#abre o bd

conexao = sqlite3.connect("restaurante.db")

#deixa executar comandos SQL

cursor = conexao.cursor()

# Cria a tabela de pedidos

cursor.execute("""
CREATE TABLE IF NOT EXISTS pedidos (
id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
quantidade_itens INTEGER NOT NULL,
tempo_preparo_minutos REAL NOT NULL
)
""")

# Salva as alterações e fecha a conexão

conexao.commit()
conexao.close()

print("Banco de dados criado com sucesso!")