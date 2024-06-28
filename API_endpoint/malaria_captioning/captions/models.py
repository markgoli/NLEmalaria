# # # from django.db import models

# # Create your models here.
# # captions/model.py
# from transformers import VisionEncoderDecoderModel, ViTFeatureExtractor, GPT2Tokenizer, ViTImageProcessor

# # model_name = "BRIAN12682/microscopy-image-captioning"
# model_name = "BRIAN12682/malaria-captioning-v2"
# model = VisionEncoderDecoderModel.from_pretrained(model_name)
# #feature_extractor = ViTFeatureExtractor.from_pretrained(model_name)
# image_processor = ViTImageProcessor.from_pretrained(model_name)
# tokenizer = GPT2Tokenizer.from_pretrained(model_name)

# def predict_caption(image_path, max_length=50):
#     from PIL import Image
#     image = Image.open(image_path)
#     if image.mode != "RGB":
#         image = image.convert("RGB")
    
#     # pixel_values = feature_extractor(images=image, return_tensors="pt").pixel_values
#     pixel_values = image_processor(images=image, return_tensors="pt").pixel_values
#     output_ids = model.generate(pixel_values, max_length=max_length)
#     caption = tokenizer.decode(output_ids[0], skip_special_tokens=True)
#     return caption


# captions/model.py
# captions/model.py
# captions/model.py
# myapp/model.py
# myapp/model.py
from transformers import VisionEncoderDecoderModel, ViTImageProcessor, AutoTokenizer
from PIL import Image

class MalariaCaptioningModel:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(MalariaCaptioningModel, cls).__new__(cls)
            cls._instance.model_name = "BRIAN12682/malaria-captioning-v2"
            cls._instance.model = VisionEncoderDecoderModel.from_pretrained(cls._instance.model_name)
            cls._instance.feature_extractor = ViTImageProcessor.from_pretrained(cls._instance.model_name)
            cls._instance.tokenizer = AutoTokenizer.from_pretrained(cls._instance.model_name)
        return cls._instance

    def predict_caption(self, image: Image.Image, max_length=100) -> str:
        if image.mode != "RGB":
            image = image.convert("RGB")
        
        pixel_values = self.feature_extractor(images=image, return_tensors="pt").pixel_values
        output_ids = self.model.generate(pixel_values, max_length=max_length)
        caption = self.tokenizer.decode(output_ids[0], skip_special_tokens=True)
        return caption


# # Usage
# captioning_model = MalariaCaptioningModel()
# caption = captioning_model.predict_caption("path_to_image.jpg")
# print(caption)


# # captions/model.py
# # captions/model.py

# ######1111

# from transformers import VisionEncoderDecoderModel, ViTFeatureExtractor, AutoTokenizer
# import os

# # Ensure the model is downloaded
# from download_model import download_model_files
# download_model_files()

# model_path = "vitgpt_model"  # Path where the model is saved after download

# model = VisionEncoderDecoderModel.from_pretrained(model_path)
# feature_extractor = ViTFeatureExtractor.from_pretrained(model_path)
# tokenizer = AutoTokenizer.from_pretrained(model_path)

# def predict_caption(image_path, max_length=50):
#     from PIL import Image
#     image = Image.open(image_path)
#     if image.mode != "RGB":
#         image = image.convert("RGB")

#     pixel_values = feature_extractor(images=image, return_tensors="pt").pixel_values
#     output_ids = model.generate(pixel_values, max_length=max_length)
#     caption = tokenizer.decode(output_ids[0], skip_special_tokens=True)
#     return caption


# ######2222222
# # captions/model.py
# # from transformers import VisionEncoderDecoderModel, ViTFeatureExtractor, AutoTokenizer
# # import os

# # # Ensure the model is downloaded and reassembled
# # from download_and_reassemble import download_and_reassemble_model
# # download_and_reassemble_model()

# # model_path = "vitgpt_model"  # Path where the model is saved after download

# # model = VisionEncoderDecoderModel.from_pretrained(model_path)
# # feature_extractor = ViTFeatureExtractor.from_pretrained(model_path)
# # tokenizer = AutoTokenizer.from_pretrained(model_path)

# # def predict_caption(image_path):
# #     from PIL import Image
# #     image = Image.open(image_path)
# #     if image.mode != "RGB":
# #         image = image.convert("RGB")

# #     pixel_values = feature_extractor(images=image, return_tensors="pt").pixel_values
# #     output_ids = model.generate(pixel_values)
# #     caption = tokenizer.decode(output_ids[0], skip_special_tokens=True)
# #     return caption
