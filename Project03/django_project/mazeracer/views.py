from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from django.urls import path
from django.contrib import admin

def mazeRacerGame(request): # Simply renders the Maze Racer game as HTML, no context/data sent/recieved.
    template = loader.get_template('project3.html')
    return HttpResponse(template.render())

