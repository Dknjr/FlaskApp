from flask import Flask, jsonify

app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello, World!'


@app.route('/health')
def health():
    """Route de santé : permet à Docker ou à un outil de supervision de vérifier que le service répond."""
    return jsonify(status='ok'), 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
