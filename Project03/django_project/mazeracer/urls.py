from django.urls import path
from . import views


urlpatterns = [
	path(' ',views.mazeRacerDisplay, name='mazeracer-gameDisplay'),

]
