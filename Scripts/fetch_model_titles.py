import os
import re
import requests
from bs4 import BeautifulSoup

# Get the folder where the script is located
script_dir = os.path.dirname(os.path.abspath(__file__))

# Go one folder up and then into image_downloads\Model_ID_Search
base_path = os.path.join(script_dir, "..", "image_downloads", "Model_ID_Search")
base_path = os.path.abspath(base_path)  # Optional: makes sure it's fully resolved

headers = {'User-Agent': 'Mozilla/5.0'}

# Debug output to confirm paths
# print("Script is running from:", script_dir)
# print("Resolved base_path:", base_path)
# print()

if not os.path.exists(base_path):
    print("❌ ERROR: base_path does not exist!")
    input("Press Enter to exit...")
    exit()


headers = {'User-Agent': 'Mozilla/5.0'}

for folder_name in os.listdir(base_path):
    if folder_name.startswith("model_"):
        model_id = folder_name.replace("model_", "")
        folder_path = os.path.join(base_path, folder_name)
        if os.path.isdir(folder_path):
            url = f"https://civitai.com/models/{model_id}"

            try:
                response = requests.get(url, headers=headers, timeout=10)
                soup = BeautifulSoup(response.text, 'html.parser')
                # Sanitize title
                title = re.sub(r'[\\/*?:"<>|]', "-", soup.title.string.strip())
                filename = f"{model_id} - {title}.url"
            except Exception as e:
                print(f"Error fetching title for model {model_id}: {e}")
                filename = f"{model_id}.url"

            shortcut_path = os.path.join(base_path, filename)
            with open(shortcut_path, 'w', encoding="utf-8") as f:
                f.write("[InternetShortcut]\n")
                f.write(f"URL={url}\n")

print(" ")
print("✅ URL Created")
print(" ")