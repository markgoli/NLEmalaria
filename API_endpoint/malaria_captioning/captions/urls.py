# # captions/urls.py
# from django.urls import path
# from .views import caption_image

# urlpatterns = [
#     path('caption/', caption_image, name='caption_image'),
# ]
# captions/urls.py
from django.urls import path
from .views import caption_image_api, caption_image_web

urlpatterns = [
    path('caption/api/', caption_image_api, name='caption_image_api'),
    path('caption/web/', caption_image_web, name='caption_image_web'),
]
