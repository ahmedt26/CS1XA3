from django.urls import path
from . import views


urlpatterns = [
	path('Project03/' ,views.mazeRacerGame, name='MazeRacer'),

]
