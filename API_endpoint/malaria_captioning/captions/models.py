from django.db import models

# Create your models here.
# captions/model.py
from transformers import VisionEncoderDecoderModel, ViTFeatureExtractor, AutoTokenizer

model_name = "nlpconnect/vit-gpt2-image-captioning"
model = VisionEncoderDecoderModel.from_pretrained(model_name)
feature_extractor = ViTFeatureExtractor.from_pretrained(model_name)
tokenizer = AutoTokenizer.from_pretrained(model_name)

def predict_caption(image_path):
    from PIL import Image
    image = Image.open(image_path)
    if image.mode != "RGB":
        image = image.convert("RGB")
    
    pixel_values = feature_extractor(images=image, return_tensors="pt").pixel_values
    output_ids = model.generate(pixel_values)
    caption = tokenizer.decode(output_ids[0], skip_special_tokens=True)
    return caption
