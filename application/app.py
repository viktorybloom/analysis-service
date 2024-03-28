# app.py

from flask import Flask, render_template, redirect, url_for, request

app = Flask(__name__)

# Routes for different services

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/postgres')
def postgres():
    # Logic to interact with PostgreSQL service
    return render_template('postgres.html')

@app.route('/neo4j')
def neo4j():
    # Logic to interact with Neo4j service
    return render_template('neo4j.html')

@app.route('/jupyter')
def jupyter():
    # Logic to interact with Jupyter service
    return render_template('jupyter.html')

# Database management routes

@app.route('/manage_database', methods=['GET', 'POST'])
def manage_database():
    if request.method == 'POST':
        # Logic to manage database based on user input
        return redirect(url_for('index'))
    return render_template('manage_database.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)

