# from django.apps import AppConfig


# class CaptionsConfig(AppConfig):
#     default_auto_field = 'django.db.models.BigAutoField'
#     name = 'captions'


# myapp/apps.py
from django.apps import AppConfig
from .models import MalariaCaptioningModel

class MyAppConfig(AppConfig):
    name = 'captions'

    def ready(self):
        global model
        model = MalariaCaptioningModel()
