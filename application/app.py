# app.py

from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return app.send_static_file('index.html')

@app.route('/api/<service>')
def call_service(service):
    # Add logic to handle different services
    return f"Calling {service} service..."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)

