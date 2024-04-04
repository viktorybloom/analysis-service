from flask import Flask, render_template

HOST = '0.0.0.0'
PORT = 5000 

app = Flask(__name__)

@app.route('/templates')
def service_status():
    # just a basic check to ensure that the service/server is up.
    return render_template('service-status.html')

if __name__ == '__main__':
    app.run(host=HOST, port=PORT)
