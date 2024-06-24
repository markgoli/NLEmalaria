# captions/urls.py
from django.urls import path
from .views import caption_image

urlpatterns = [
    path('caption/', caption_image, name='caption_image'),
]
