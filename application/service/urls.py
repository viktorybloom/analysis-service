# myapp/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('postgres/', views.postgres, name='postgres'),
    path('neo4j/', views.neo4j, name='neo4j'),
    path('jupyter/', views.jupyter, name='jupyter'),
    path('manage_database/', views.manage_database, name='manage_database'),
]

