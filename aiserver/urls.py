from django.urls import path
from . import views

urlpatterns = [
    path('processFile', views.process_file, name='process_file'),
    path('testDB', views.test_db, name='test_db'),
    path('getResult', views.getResult, name='get_result'),
]