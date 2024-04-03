# myapp/views.py
from django.shortcuts import render, redirect

def index(request):
    return render(request, 'index.html')

def postgres(request):
    # Logic to interact with PostgreSQL service
    return render(request, 'postgres.html')

def neo4j(request):
    # Logic to interact with Neo4j service
    return render(request, 'neo4j.html')

def jupyter(request):
    # Logic to interact with Jupyter service
    return render(request, 'jupyter.html')

def manage_database(request):
    if request.method == 'POST':
        # Logic to manage database based on user input
        return redirect('index')
    return render(request, 'manage_database.html')

