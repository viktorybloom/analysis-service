# analysis-service/application/urls.py
from django.urls import path, include

urlpatterns = [
    path('', include('service.urls')),
]

