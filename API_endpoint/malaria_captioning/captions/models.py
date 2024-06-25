from django.db import models

# Create your models here.
# captions/model.py
from transformers import VisionEncoderDecoderModel, ViTFeatureExtractor, GPT2Tokenizer

model_name = "BRIAN12682/microscopy-image-captioning"
model = VisionEncoderDecoderModel.from_pretrained(model_name)
feature_extractor = ViTFeatureExtractor.from_pretrained(model_name)
tokenizer = GPT2Tokenizer.from_pretrained(model_name)

def predict_caption(image_path, max_length=50):
    from PIL import Image
    image = Image.open(image_path)
    if image.mode != "RGB":
        image = image.convert("RGB")
    
    pixel_values = feature_extractor(images=image, return_tensors="pt").pixel_values
    output_ids = model.generate(pixel_values, max_length=max_length)
    caption = tokenizer.decode(output_ids[0], skip_special_tokens=True)
    return caption
