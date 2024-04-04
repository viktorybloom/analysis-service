from flask import Flask

HOST = '0.0.0.0'
PORT = 8080

app = Flask(__name__)




if __name__ == '__main__':
    app.run(host=HOST, port=PORT)
