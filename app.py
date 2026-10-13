from flask import Flask, request, render_template
from regressao import buscar_dados, calcular_regressao_manual

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    tempo_estimado = None
    quantidade_itens = None
    erro = None
    if request.method == "POST":
        try:
            quantidade_itens = int(request.form["quantidade_itens"])

            if quantidade_itens <= 0:
                raise ValueError("A quantidade deve ser maior que zero.")

            X, Y = buscar_dados()

            beta0, beta1 = calcular_regressao_manual(X, Y)

            tempo_estimado = beta0 + beta1 * quantidade_itens

        except ValueError as e:
            erro = str(e)

    return render_template(
        "index.html",
        quantidade_itens=quantidade_itens,
        tempo_estimado=tempo_estimado,
        erro=erro
    )

if __name__ == "__main__":
    app.run(debug=True)