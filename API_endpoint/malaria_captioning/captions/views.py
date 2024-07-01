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
# from django.shortcuts import render
# from django.http import JsonResponse
# from django.views.decorators.csrf import csrf_exempt
# from django.core.cache import cache
# from django.core.files.uploadedfile import InMemoryUploadedFile
# from django.core.files.storage import default_storage
# from asgiref.sync import sync_to_async
# import io
# import hashlib
# from PIL import Image
# from .models import MalariaCaptioningModel

# # Preload the model
# model = MalariaCaptioningModel()

# @csrf_exempt
# async def caption_image_api(request):
#     if request.method == 'POST' and 'image' in request.FILES:
#         image = request.FILES['image']
#         image_data = await sync_to_async(image.read)()
#         image = Image.open(io.BytesIO(image_data))

#         image_hash = hashlib.md5(image_data).hexdigest()
#         caption = cache.get(image_hash)
#         if not caption:
#             caption = await sync_to_async(model.predict_caption)(image)
#             cache.set(image_hash, caption, timeout=60*15)

#         return JsonResponse({'caption': caption})
#     else:
#         return JsonResponse({'error': 'No image provided'}, status=400)

# def caption_image_web(request):
#     if request.method == 'POST' and 'image' in request.FILES:
#         image = request.FILES['image']
#         image_data = image.read()
#         image = Image.open(io.BytesIO(image_data))

#         image_hash = hashlib.md5(image_data).hexdigest()
#         caption = cache.get(image_hash)
#         if not caption:
#             caption = model.predict_caption(image)
#             cache.set(image_hash, caption, timeout=60*15)

#         # Save the image to the default storage and generate a URL
#         image_name = image._name if isinstance(image, InMemoryUploadedFile) else "uploaded_image.jpg"
#         image_io = io.BytesIO(image_data)
#         saved_image_path = default_storage.save(image_name, image_io)
#         image_url = default_storage.url(saved_image_path)

#         return render(request, 'caption/caption_result.html', {'caption': caption, 'image_url': image_url})
#     return render(request, 'caption/upload_image.html')






# # # captions/views.py

# # @csrf_exempt
# # @api_view(['GET', 'POST'])
# # def caption_image_in_flutter(request):
# #     if request.method == 'POST' and 'image' in request.FILES:
# #         image = request.FILES['image']
# #         image_path = default_storage.save(image.name, image)
# #         full_image_path = os.path.join(default_storage.location, image_path)
        
# #         caption = predict_caption(full_image_path)
        
# #         return JsonResponse({'caption': caption})
# #     else:
# #         return JsonResponse({'error': 'No image provided'}, status=400)


# captions/views.py
# captions/views.py
# captions/views.py
# captions/views.py
# captions/views.py

from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.core.files.storage import default_storage
from PIL import Image
import os
from .models import MalariaCaptioningModel
from googletrans import Translator

translator = Translator()

def translate(text, target_lang):
    translated = translator.translate(text, dest=target_lang)
    return translated.text

@csrf_exempt
def caption_image_api(request):
    if request.method == 'POST' and 'image' in request.FILES:
        image = request.FILES['image']
        image_path = default_storage.save(image.name, image)
        full_image_path = os.path.join(default_storage.location, image_path)
        
        image = Image.open(full_image_path)
        captioning_model = MalariaCaptioningModel()
        caption = captioning_model.predict_caption(image)
        
        target_lang = request.POST.get('lang', 'en')
        
        if target_lang != 'en':
            caption = translate(caption, target_lang)
        
        return JsonResponse({'caption': caption})
    else:
        return JsonResponse({'error': 'No image provided'}, status=400)

def caption_image_web(request):
    if request.method == 'POST':
        image_path = request.POST.get('image_path')
        if not image_path and 'image' in request.FILES:
            image = request.FILES['image']
            image_path = default_storage.save(image.name, image)
        
        full_image_path = os.path.join(default_storage.location, image_path)
        image = Image.open(full_image_path)
        
        captioning_model = MalariaCaptioningModel()
        caption = captioning_model.predict_caption(image)
        
        target_lang = request.POST.get('lang', 'en')
        if target_lang != 'en':
            caption = translate(caption, target_lang)
        
        return render(request, 'caption/caption_result.html', {
            'caption': caption,
            'image_url': default_storage.url(image_path),
            'image_path': image_path
        })
    return render(request, 'caption/upload_image.html')
