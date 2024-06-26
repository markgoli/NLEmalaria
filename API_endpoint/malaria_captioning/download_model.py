import gdown
import os

def download_file_from_gdrive(file_id, file_name):
    url = f"https://drive.google.com/uc?id={file_id}"
    output = file_name
    gdown.download(url, output, quiet=False)

def download_model_files():
    files = {
        "vocab.json": "1z9I71ekVrqnVrY7SZDESu2mRo9IPpl0s",
        "config.json": "1z8JF-4iAWu2joBpy0VeUjHrMJJD3WYD8",
        "generation_config.json": "1dtwEP4OpyUPApkMtQ75KKA3VlAH3EfyW",
        "tokenizer_config.json": "1sxNadNwxOwumNncI9_1RAb8cYTUh2Ml-",
        "special_tokens_map.json": "1rjwwrHqxb-rO7EBGp-Aaf5v_fHEJrmY2",
        "preprocessor_config.json": "1--5qIurrkPklSNrtb-GdzQ4SwoWWinIq",
        "model.safetensors": "16757LGDTpeBr4PUsAhOkBdL4Xj9AmJkj",
        "merges.txt": "1vUoifN6u3BTORtW_yVmXkWroILNdLUUx",
        # Add more files as needed
    }

    if not os.path.exists('vitgpt_model'):
        os.mkdir('vitgpt_model')

    for file_name, file_id in files.items():
        download_file_from_gdrive(file_id, os.path.join('vitgpt_model', file_name))

if __name__ == "__main__":
    download_model_files()
