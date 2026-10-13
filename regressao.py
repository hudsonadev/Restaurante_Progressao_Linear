#Cola - Ativar ambiente virtual: .\.venv\Scripts\Activate.ps1
import sqlite3
import numpy as np

def buscar_dados():
    conexao = sqlite3.connect("restaurante.db")
    cursor = conexao.cursor()
    cursor.execute("""
        SELECT quantidade_itens, tempo_preparo_minutos
        FROM pedidos
    """)

    registros = cursor.fetchall()
    conexao.close()

    X = [registro[0] for registro in registros]
    Y = [registro[1] for registro in registros]

    return X, Y

def calcular_regressao_manual(X, Y):
    #verificando se os arrays são do mesmo tamanho
    if len(X) != len(Y):
        raise ValueError(
        "X e Y precisam ter a mesma quantidade de registros."
        )
    n = len(X)

    #verificando se existem dados suficientes - min 2 
    if n < 2:
        raise ValueError(
            "São necessários pelo menos dois registros."
        )

    #pegando as médias de x e y
    media_x = sum(X) / n
    media_y = sum(Y) / n

    numerador = 0
    denominador = 0

    #calculando os valores necessários para Beta 1 seguindo a formula

    for i in range(n):
        numerador += (X[i] - media_x) * (Y[i] - media_y)
        denominador += (X[i] - media_x) ** 2

    #evita divisão por zero se todos os valores de X forem iguais
    if denominador == 0:
        raise ValueError(
            "Os valores de X precisam apresentar variação."
        )

    #calculando os coeficientes a partir dos dados obtidos
    beta1 = numerador / denominador
    beta0 = media_y - beta1 * media_x

    return beta0, beta1

#buscando os dados direto do banco
if __name__ == "__main__":
    X, Y = buscar_dados();
    print("Quantidade de pedidos: ", len(X))
    beta0_manual, beta1_manual = calcular_regressao_manual(X,Y)

    print("Regressão Calculada manualmente:")
    print("Beta 0: ", beta0_manual)
    print("Beta 1: ", beta1_manual)

    # -----------COMPARAÇÃO USANDO A BILBIOTECA NUMPY -------------
    #calcula os coeficientes usando NumPy
    #so p lembrar, a funcao polyfit retorna primeiro o coeficiente angular, vulgo b1 e depois o intercepto, b0
    beta1_numpy, beta0_numpy = np.polyfit(X, Y, 1)

    print("\nRegressão calculada com NumPy")
    print("Beta 0:", beta0_numpy)
    print("Beta 1:", beta1_numpy)

    # Compara os resultados

    print("\nComparação dos resultados")

    print(
    "Beta 0 iguais?",
    np.isclose(beta0_manual, beta0_numpy)
    )

    print(
    "Beta 1 iguais?",
    np.isclose(beta1_manual, beta1_numpy)
    )

    #hora da verdade
    quantidade_itens = 4

    tempo_estimado = beta0_manual + beta1_manual * quantidade_itens

    print("\nPrevisão para um novo pedido")
    print("Quantidade de itens:", quantidade_itens)
    print(f"Tempo estimado: {tempo_estimado:.2f} minutos")