# download_model.py
import gdown
import os

def download_model_from_gdrive():
    # Replace with your Google Drive shared link
    url = 'https://drive.google.com/drive/folders/10t4s6guVxj2_8PRjoMOdQ3tGj1UUg3uU?usp=sharing'
    
    # Path to save the downloaded model
    output = 'vitgpt_model.zip'
    
    if not os.path.exists('vitgpt_model'):
        gdown.download(url, output, quiet=False)
        os.system('unzip vitgpt_model.zip')

if __name__ == "__main__":
    download_model_from_gdrive()
