import gdown
import os

def download_file_from_gdrive(file_id, file_name):
    url = f"https://drive.google.com/uc?id={file_id}"
    output = file_name
    gdown.download(url, output, quiet=False)

def download_and_reassemble_model():
    chunks = [
        {"file_name": "model.safetensors.part-aa", "file_id": "your_file_id_for_part_aa"},
        {"file_name": "model.safetensors.part-ab", "file_id": "your_file_id_for_part_ab"},
        {"file_name": "model.safetensors.part-ac", "file_id": "your_file_id_for_part_ac"},
        {"file_name": "model.safetensors.part-ad", "file_id": "your_file_id_for_part_ad"},
        {"file_name": "model.safetensors.part-ae", "file_id": "your_file_id_for_part_ae"},
        {"file_name": "model.safetensors.part-af", "file_id": "your_file_id_for_part_af"},
        {"file_name": "model.safetensors.part-ag", "file_id": "your_file_id_for_part_ag"},
        {"file_name": "model.safetensors.part-ah", "file_id": "your_file_id_for_part_ah"},
        {"file_name": "model.safetensors.part-ai", "file_id": "your_file_id_for_part_ai"},
        {"file_name": "model.safetensors.part-aj", "file_id": "your_file_id_for_part_aj"},
        {"file_name": "model.safetensors.part-ak", "file_id": "your_file_id_for_part_ak"},
        {"file_name": "model.safetensors.part-al", "file_id": "your_file_id_for_part_al"},
        {"file_name": "model.safetensors.part-am", "file_id": "your_file_id_for_part_am"},
        {"file_name": "model.safetensors.part-an", "file_id": "your_file_id_for_part_an"},
        {"file_name": "model.safetensors.part-ao", "file_id": "your_file_id_for_part_ao"},
        {"file_name": "model.safetensors.part-ap", "file_id": "your_file_id_for_part_ap"},
        {"file_name": "model.safetensors.part-aq", "file_id": "your_file_id_for_part_aq"},
        {"file_name": "model.safetensors.part-ar", "file_id": "your_file_id_for_part_ar"},
        {"file_name": "model.safetensors.part-as", "file_id": "your_file_id_for_part_as"},
        {"file_name": "model.safetensors.part-at", "file_id": "your_file_id_for_part_at"}
        # Add more chunks as needed
    ]

    if not os.path.exists('vitgpt_model'):
        os.mkdir('vitgpt_model')

    for chunk in chunks:
        file_name = chunk["file_name"]
        file_id = chunk["file_id"]
        download_file_from_gdrive(file_id, os.path.join('vitgpt_model', file_name))

    # Reassemble the chunks into the original file
    with open('vitgpt_model/model.safetensors', 'wb') as output_file:
        for chunk in chunks:
            with open(os.path.join('vitgpt_model', chunk["file_name"]), 'rb') as input_file:
                output_file.write(input_file.read())

if __name__ == "__main__":
    download_and_reassemble_model()
