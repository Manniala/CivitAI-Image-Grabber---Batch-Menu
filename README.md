# 🖼️ CivitAI Image Grabber - Batch Menu v1.2

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
- Run this to install required Python modules (Only if you use "Make Model URL With Name.bat"):
  ```bash
  pip install requests beautifulsoup4
  ```
- Clone/download the [CivitAI_Image_grabber](https://github.com/Confuzu/CivitAI_Image_grabber)

## 🚀 Usage

1. Clone or download this repo.
2. Place this inside the rood of [CivitAI_Image_grabber](https://github.com/Confuzu/CivitAI_Image_grabber) folder.
3. Run `menu.bat` from the root folder to launch the dynamic menu.
4. To remove unused menu items, just delete the corresponding `.bat` files from `Scripts`.

## 🤝 Contribution

This batch menu is intended to support tools developed by [Confuzu](https://github.com/Confuzu)
Feel free to fork, improve, and suggest changes — especially new script ideas for the menu!


## 📦 Installation

📝 Note: If placing this inside the original CivitAI_Image_grabber repo, consider renaming this file to README-menu.md to avoid overwriting the main README.

You can install the batch menu in two ways: manually or via pip.

🔧 Option 1: Manual Download

1. Download or clone this repo:
    git clone https://github.com/Manniala/CivitAI-Image-Grabber---Batch-Menu
   Or click Code > Download ZIP on GitHub and extract it.

2. Copy the contents into the same folder as the original `civit_image_downloader.py`:
   (https://github.com/Confuzu/CivitAI_Image_grabber)

3. Open the folder and run `menu.bat`.

🐍 Option 2: Install via pip (for easier updating)

> This will install the menu system as a Python package.

1. Open a terminal (Command Prompt or PowerShell).
2. Run:
    pip install git+https://github.com/YourUsername/CivitAI-Image-Grabber-Menu.git
3. Navigate to your project folder where `civit_image_downloader.py` is located.
4. Run:
    menu.bat

📁 Folder Setup

Make sure the structure looks like this:

```
CivitAI_Image_grabber/
│  └── Scripts/                            <-- Place additional .bat and .py tools here
│      ├── Civit Image Downloader.bat      <-- Starts civit_image_downloader.py
│      ├── Download Artist.bat             <-- Downloads images by artist
│      ├── Download Model.bat              <-- Downloads images by model ID
│      ├── Edit Artist's.bat               <-- Opens Edit Options for Artist's
│      ├── Edit Model's.bat                <-- Opens Edit Options for Model's
│      ├── Fetch_model_titles.py
│      ├── Make Model Url With Name.bat    <-- Starts fetch_model_titles.py
│      ├── Make URL For Artist's.bat       <-- Generates download URLs for artists
│      ├── Make URL For Model's.bat        <-- Generates download URLs for models
│      ├── Set Wait Time.bat               <-- Sets the Wait Time
│      ├── Wait_time.txt                   <-- Wait Time .txt file
│      ├──── Artist/
│      │     ├── Portrait.txt              <-- Empty .txt file used as Example in Menu
│      │     ├── Landscape.txt             <-- (Edit or Delete if not needed)
│      │     └── NSFW.txt
│      └──── Model/
│            ├── Character.txt
│            ├── Checkpoint.txt
│            └── Vehicles.txt
├── civit_image_downloader.py              <-- From https://github.com/Confuzu/CivitAI_Image_grabber
├── Menu.bat
├── README.md                              <-- Project overview and usage instructions
└── tagnames.py                            <-- From https://github.com/Confuzu/CivitAI_Image_grabber
```

## General Usage

The way it works is pretty simple:

You place artist names or model IDs into their respective `.txt` files — for example, `Download_Artist.txt` or `Download_Model_ID.txt`.

Then, when you launch the menu and choose an option like `2. Download Artist`, it will go through the list in `Download_Artist.txt` and download content from each artist automatically.

This setup is great for tracking multiple artists or models — you don’t have to remember who you were following or type anything manually each time. Just run the menu and press a number. It will only download new content (as long as you don’t delete the `tracking_database.sqlite`, which is what keeps track of what has already been downloaded).

What makes the menu flexible is that it automatically includes all `.bat` files from the `Scripts/` folder. That means you can create multiple download scripts with different `.txt` files for organizing or separating download types — e.g., one for NSFW content, one for SFW, or one specifically for LoRAs. You just copy an existing `.bat` file and change line 9 to point to your new `.txt` list.


💬 Answer to a Common Question

> “Is the intention of the artist.txt and artist.bat to save you from having to type the name every time? Or will it detect the previous process has completed and launch grabber again with the next username?”

Great question!
Yes — the main goal of the `.txt` and `.bat` files is to save you from having to type names or IDs every time. You just edit the list once, and from then on, it’ll pull from that file whenever you launch the script.


## Added - 26 April 2025
- Added 'Set Wait Time.bat' to configure wait time between downloads
- Created 'wait_time.txt' to store delay value (in seconds)
- Updated 'Download Artist.bat' and 'Download Model.bat' to:
    - Read one name per line from their respective .txt files
    - Download each artist/model individually with a timed delay
    - Show the name of the next artist/model before continuing
- Reduced API spam risk by spacing out download requests
- Displayed current wait time in the menu using ANSI color
- Enhanced clarity and safety for both user experience and API usage

## Edit/Added - 26 April 2025 - Changed to v1.2

Update Summary:

- New folder structure:  
  - Scripts\\Artist\\ for artist `.txt` lists  
  - Scripts\\Model\\ for model `.txt` lists

- Download Artist.bat and Download Model.bat updated:
  - Now search inside Scripts\\Artist\\ and Scripts\\Model\\ respectively.
  - Automatically list all available `.txt` files (without showing `.txt` extension).
  - User can select which artist or model list to run.

- Edit Artist's.bat and Edit Model's.bat updated:
  - Allow editing any `.txt` file from Scripts\\Artist\\ or Scripts\\Model\\.
  - Show a numbered menu for easier selection.
  - Safe range-checking to prevent invalid selections or errors.

- Improved error handling across .bat files:
  - If no `.txt` files are found, user is notified cleanly.
  - If an invalid choice is made, the script exits safely with a message.

- Minor fixes:
  - Corrected a typo: "Downloading fromm" → "Downloading from".
  - Standardized ANSI color usage (optional color improvements).

Folder structure now:

```
Scripts/
├── Artist/
│   ├── Portrait.Artist.txt
│   ├── Landscape.Artist.txt
│   └── NSFW.Artist.txt
├── Model/
│   ├── Character.Model.txt
│   └── Vehicles.Model.txt
Civit Image Downloader.bat
├── Download Artist.bat
├── Download Model.bat
├── Edit Artist's.bat
├── Edit Model's.bat
├── Fetch_model_titles.py
├── Make Model Url With Name.bat
├── Make URL For Artist's.bat
├── Make URL For Model's.bat
├── Set Wait Time.bat
└── Wait_time.txt
```

✨ This update makes it easier to manage large sets of artists or models by keeping them organized into separate lists!
