from django.urls import path
from . import views

# routed from e/macid/userlogin/
urlpatterns = [
    path('sessionincr/', views.session_incr , name = 'userauthapp-sesson_incr') ,
    path('sessionget/', views.session_get , name = 'userauthapp-sesson_get') ,
    path('adduser/', views.add_user , name = 'userauthapp-add_user') ,
    path('loginuser/', views.login_user , name = 'userauthapp-login_user') ,
    path('userinfo/', views.user_info , name = 'userauthapp-user_info') ,
]

