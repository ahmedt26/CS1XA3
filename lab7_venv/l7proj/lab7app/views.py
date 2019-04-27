from django.shortcuts import render
from django.http import HttpResponse
from django.urls import path
from django.contrib import admin

def postReq(request):
	user = request.POST.get("name","")
	password = request.POST.get("password","")

	if user == "Jimmy" and password == "Hendrix":
		return HttpResponse("Cool")
	else:
		return HttpResponse("Bad User Name")
