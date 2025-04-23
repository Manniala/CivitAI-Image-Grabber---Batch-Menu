# 🖼️ CivitAI Image Grabber - Batch Menu

![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Python](https://img.shields.io/badge/python-3.8%2B-blue.svg)
![License](https://img.shields.io/github/license/Confuzu/CivitAI_Image_grabber?style=flat)

This repository contains a Windows batch file menu system to launch and manage scripts related to [CivitAI_Image_grabber](https://github.com/Confuzu/CivitAI_Image_grabber). It includes helpful automation tools for downloading images by model or artist, and organizing them in an easy-to-use structure.

---

## 🔧 Features

- Auto-generates a menu from all `.bat` files inside the `Scripts/` folder.
- Launch Python tools for enhanced naming, downloading, and organization.
- Quickly fetch model titles using Python and update URLs for easier navigation.
- Edit your artist/model lists using quick-access `.bat` tools.
- Run in "light mode" with no Python — just use `.bat` utilities to save artist/model links.

---

## 📦 Requirements

- **Windows**
- **Python** installed and added to PATH
- Run this to install required Python modules:
  ```bash
  pip install requests beautifulsoup4
  ```
- Clone/download the [CivitAI_Image_grabber](https://github.com/Confuzu/CivitAI_Image_grabber)

## 🚀 Usage

1. Clone or download this repo.
2. Place this inside the  [CivitAI_Image_grabber](https://github.com/Confuzu/CivitAI_Image_grabber) scripts folder.
3. Run `menu.bat` from the root folder to launch the dynamic menu.
4. To remove unused menu items, just delete the corresponding `.bat` files from `Scripts`.

## 🗂 Folder Structure

```
CivitAI_Image_grabber/
│
├── menu.bat                          # Main menu launcher
├── Scripts/                          # Place additional .bat and .py tools here
│   ├── Civit Image Downloader.bat    # Starts civit_image_downloader.py
│   ├── Download Artist.bat           # Downloads images by artist (uses Download_Artist.txt)
│   ├── Download Model.bat            # Downloads images by model ID (uses Download_Model_ID.txt)
│   ├── Download_Artist.txt           # Example artist URLs
│   ├── Download_Model_ID.txt         # Example model IDs
│   ├── Edit Artist's.bat             # Opens Download_Artist.txt for editing
│   ├── Edit Model's.bat              # Opens Download_Model_ID.txt for editing
│   ├── fetch_model_titles.py         # Converts model IDs to full model names
│   ├── Make Model URL With Name.bat  # Starts fetch_model_titles.py
│   ├── Make URL For Artist's.bat     # Generates download URLs for artists
│   ├── Make URL For Model's.bat      # Generates download URLs for models
├── image_downloads/                  # Where downloaded content is stored
└── README.md                         # Project overview and usage instructions
```

## 🤝 Contribution

This batch menu is intended to support tools developed by [Confuzu](https://github.com/Confuzu)
Feel free to fork, improve, and suggest changes — especially new script ideas for the menu!




