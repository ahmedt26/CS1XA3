from django.shortcuts import render
from django.http import HttpResponse
from django.urls import path
from django.contrib import admin

def mazeRacerDisplay(request):
     html = "<html><body>Hello World</body></html>"
     return HttpResponse(html)
