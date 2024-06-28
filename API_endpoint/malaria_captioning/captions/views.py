# # captions/views.py

# from django.shortcuts import render
# from django.http import JsonResponse
# from django.views.decorators.csrf import csrf_exempt
# from django.core.files.storage import default_storage
# from .models import predict_caption
# import os

# @csrf_exempt
# def caption_image_api(request):
#     if request.method == 'POST' and 'image' in request.FILES:
#         image = request.FILES['image']
#         image_path = default_storage.save(image.name, image)
#         full_image_path = os.path.join(default_storage.location, image_path)
        
#         caption = predict_caption(full_image_path)
        
#         return JsonResponse({'caption': caption})
#     else:
#         return JsonResponse({'error': 'No image provided'}, status=400)

# def caption_image_web(request):
#     if request.method == 'POST' and 'image' in request.FILES:
#         image = request.FILES['image']
#         image_path = default_storage.save(image.name, image)
#         full_image_path = os.path.join(default_storage.location, image_path)
        
#         caption = predict_caption(full_image_path)
        
#         return render(request, 'caption/caption_result.html', {'caption': caption, 'image_url': default_storage.url(image_path)})
#     return render(request, 'caption/upload_image.html')
# captions/views.py
# myapp/views.py
# myapp/views.py
# myapp/views.py
# myapp/views.py
# myapp/views.py
from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.core.cache import cache
from django.core.files.uploadedfile import InMemoryUploadedFile
from django.core.files.storage import default_storage
from asgiref.sync import sync_to_async
import io
import hashlib
from PIL import Image
from .models import MalariaCaptioningModel

# Preload the model
model = MalariaCaptioningModel()

@csrf_exempt
async def caption_image_api(request):
    if request.method == 'POST' and 'image' in request.FILES:
        image = request.FILES['image']
        image_data = await sync_to_async(image.read)()
        image = Image.open(io.BytesIO(image_data))

        image_hash = hashlib.md5(image_data).hexdigest()
        caption = cache.get(image_hash)
        if not caption:
            caption = await sync_to_async(model.predict_caption)(image)
            cache.set(image_hash, caption, timeout=60*15)

        return JsonResponse({'caption': caption})
    else:
        return JsonResponse({'error': 'No image provided'}, status=400)

def caption_image_web(request):
    if request.method == 'POST' and 'image' in request.FILES:
        image = request.FILES['image']
        image_data = image.read()
        image = Image.open(io.BytesIO(image_data))

        image_hash = hashlib.md5(image_data).hexdigest()
        caption = cache.get(image_hash)
        if not caption:
            caption = model.predict_caption(image)
            cache.set(image_hash, caption, timeout=60*15)

        # Save the image to the default storage and generate a URL
        image_name = image._name if isinstance(image, InMemoryUploadedFile) else "uploaded_image.jpg"
        image_io = io.BytesIO(image_data)
        saved_image_path = default_storage.save(image_name, image_io)
        image_url = default_storage.url(saved_image_path)

        return render(request, 'caption/caption_result.html', {'caption': caption, 'image_url': image_url})
    return render(request, 'caption/upload_image.html')
