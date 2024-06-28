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
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.core.files.storage import default_storage
from .models import predict_caption
import os
from django.core.cache import cache
from asgiref.sync import sync_to_async

@csrf_exempt
async def caption_image_api(request):
    if request.method == 'POST' and 'image' in request.FILES:
        image = request.FILES['image']
        image_path = await sync_to_async(default_storage.save)(image.name, image)
        full_image_path = os.path.join(default_storage.location, image_path)

        caption = cache.get(full_image_path)
        if not caption:
            caption = await sync_to_async(predict_caption)(full_image_path)
            cache.set(full_image_path, caption, timeout=60*15)  # Cache for 15 minutes

        return JsonResponse({'caption': caption})
    else:
        return JsonResponse({'error': 'No image provided'}, status=400)

def caption_image_web(request):
    if request.method == 'POST' and 'image' in request.FILES:
        image = request.FILES['image']
        image_path = default_storage.save(image.name, image)
        full_image_path = os.path.join(default_storage.location, image_path)

        caption = cache.get(full_image_path)
        if not caption:
            caption = predict_caption(full_image_path)
            cache.set(full_image_path, caption, timeout=60*15)  # Cache for 15 minutes

        return render(request, 'caption/caption_result.html', {'caption': caption, 'image_url': default_storage.url(image_path)})
    return render(request, 'caption/upload_image.html')






# captions/views.py

@csrf_exempt
@api_view(['GET', 'POST'])
def caption_image_in_flutter(request):
    if request.method == 'POST' and 'image' in request.FILES:
        image = request.FILES['image']
        image_path = default_storage.save(image.name, image)
        full_image_path = os.path.join(default_storage.location, image_path)
        
        caption = predict_caption(full_image_path)
        
        return JsonResponse({'caption': caption})
    else:
        return JsonResponse({'error': 'No image provided'}, status=400)




