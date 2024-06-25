# captions/views.py

from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.core.files.storage import default_storage
from .models import predict_caption
import os

@csrf_exempt
def caption_image_api(request):
    if request.method == 'POST' and 'image' in request.FILES:
        image = request.FILES['image']
        image_path = default_storage.save(image.name, image)
        full_image_path = os.path.join(default_storage.location, image_path)
        
        caption = predict_caption(full_image_path)
        
        return JsonResponse({'caption': caption})
    else:
        return JsonResponse({'error': 'No image provided'}, status=400)

def caption_image_web(request):
    if request.method == 'POST' and 'image' in request.FILES:
        image = request.FILES['image']
        image_path = default_storage.save(image.name, image)
        full_image_path = os.path.join(default_storage.location, image_path)
        
        caption = predict_caption(full_image_path)
        
        return render(request, 'caption/caption_result.html', {'caption': caption, 'image_url': default_storage.url(image_path)})
    return render(request, 'caption/upload_image.html')
