import sqlite3

# Conecta ao banco de dados

conexao = sqlite3.connect("restaurante.db")
cursor = conexao.cursor()

# Busca todos os pedidos

cursor.execute("""
SELECT quantidade_itens, tempo_preparo_minutos
FROM pedidos
""")

registros = cursor.fetchall()

# Separa os dados em X e Y

X = [registro[0] for registro in registros]
Y = [registro[1] for registro in registros]

print("Quantidade de registros:", len(registros))
print("X - Quantidade de itens:", X)
print("Y - Tempo de preparo:", Y)

conexao.close()