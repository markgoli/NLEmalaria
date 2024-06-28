# captions/tasks.py

from celery import shared_task
from .models import load_model, predict_caption

@shared_task
def generate_caption(image_path):
    # load_model()
    return predict_caption(image_path)
