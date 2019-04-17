from django.shortcuts import render
from django.http import HttpResponse
from django.urls import path
from django.contrib import admin
from django.contrib.auth import authenticate

def postReq(request):
	user = request.POST.get("name","")
	password = request.POST.get("password","")

	if user == "Jimmy" and password == "Hendrix":
		return HttpResponse("Cool")
	else:
		return HttpResponse("Bad User Name")

def session_incr(request):
   i = request.session.get('count',0)
   request.session['count'] = i + 1
   return HttpResponse('')

def session_set(request):
   return HttpResponse("Current Count: " + str(request.session['count']))

def add_user(request):
   json_req = json.loads(request.body)
   uname = json_req.get('username',' ')
   passw = json_req.get('password',' ')

   if uname != '':
      user = User.create_user(username=uname,password=passw)
      return Httpresponse('Success!')
   else:
      return HttpResponse('InvalidUsername!')

def login_user(request):
   json_req = json.loads(request.body)
   uname = json_req.get('username',' ')
   passw = json_req.get('password',' ')

   user = authenticate(request,username=uname,
                               password=passw)

   if user is not None:
      login(request.User)
      HttpResponse("User is valid")
   else:
      HttpResponse("User is invalid")

def user_info(request):
   user = request.user

  if user.is_authenticated:
     return HttpResponse("Hello!")
  else:
     return HttpResponse("I don't know you!")
