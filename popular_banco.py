import sqlite3

# Os mesmos dados simulados da regressão

X = [
1, 2, 3, 4, 5, 6, 7, 8,
1, 2, 3, 4, 5, 6, 7, 8,
1, 2, 3, 4, 5, 6, 7, 8,
1, 2, 3, 4, 5, 6, 7, 8,
1, 2, 3, 4, 5, 6, 7, 8
]

Y = [
5, 7, 11, 12, 16, 18, 22, 24,
6, 8, 9, 13, 14, 20, 21, 25,
4, 8, 10, 14, 15, 19, 23, 26,
5, 6, 10, 13, 17, 18, 22, 25,
6, 7, 12, 11, 16, 21, 24, 27
]

# Conecta ao banco

conexao = sqlite3.connect("restaurante.db")
cursor = conexao.cursor()

# Confere se os dados possuem o mesmo tamanho

if len(X) != len(Y):
    conexao.close()
    raise ValueError("X e Y precisam ter o mesmo tamanho.")

# Prepara os registros para inserção

pedidos = list(zip(X, Y))

# Insere os pedidos na tabela

cursor.executemany("""
INSERT INTO pedidos
(quantidade_itens, tempo_preparo_minutos)
VALUES (?, ?)
""", pedidos)

conexao.commit()

print(f"{len(pedidos)} pedidos inseridos com sucesso!")

conexao.close()