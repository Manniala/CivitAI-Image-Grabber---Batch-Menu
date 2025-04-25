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
- Run this to install required Python modules (Only if you use Make Model URL With Name.bat):
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





# General Usage

The way it works is pretty simple:

You place artist names or model IDs into their respective `.txt` files — for example, `Download_Artist.txt` or `Download_Model_ID.txt`.

Then, when you launch the menu and choose an option like `2. Download Artist`, it will go through the list in `Download_Artist.txt` and download content from each artist automatically.

This setup is great for tracking multiple artists or models — you don’t have to remember who you were following or type anything manually each time. Just run the menu and press a number. It will only download new content (as long as you don’t delete the `tracking_database.sqlite`, which is what keeps track of what has already been downloaded).

What makes the menu flexible is that it automatically includes all `.bat` files from the `Scripts/` folder. That means you can create multiple download scripts with different `.txt` files for organizing or separating download types — e.g., one for NSFW content, one for SFW, or one specifically for LoRAs. You just copy an existing `.bat` file and change line 9 to point to your new `.txt` list.


💬 Answer to a Common Question

> “Is the intention of the artist.txt and artist.bat to save you from having to type the name every time? Or will it detect the previous process has completed and launch grabber again with the next username?”

Great question!
Yes — the main goal of the `.txt` and `.bat` files is to save you from having to type names or IDs every time. You just edit the list once, and from then on, it’ll pull from that file whenever you launch the script.



