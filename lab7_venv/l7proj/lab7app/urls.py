from django.urls import path
from . import views


urlpatterns = [
    path("lab7/", views.postReq, name = 'lab7app-postReq'),
    ]
