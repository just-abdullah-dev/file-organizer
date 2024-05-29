# File Organizer Script

## Introduction

This script helps you organize files in a directory by moving them into specific folders based on their file types. You can choose to organize files only in the target directory or include files in subdirectories as well.

## Purpose

The purpose of this script is to make it easy for you to keep your files organized. By running this script, you can quickly sort your files into appropriate folders, making it easier to find what you need.

## Benefits

- **Easy to use**: Just run the script with a few simple commands.
- **Time-saving**: Quickly organizes your files, saving you the time and effort of doing it manually.
- **Customizable**: You can choose to include or exclude subdirectories, and skip specific folders.

## How to Use

1. **Download the script** and make it executable:
   ```bash
   chmod +x organize.sh
   ```

2. **Run the script** with the desired command.

## Commands

### Organize files in the target directory

To organize files in the target directory without moving files in subdirectories:
```bash
./organize.sh <directory>
```
Example:
```bash
./organize.sh example/
```

### Organize files in the target directory and subdirectories

To include files in subdirectories:
```bash
./organize.sh <directory> -subdir
```
Example:
```bash
./organize.sh example/ -subdir
```

### Organize files but skip a specific subdirectory

To include files in subdirectories but skip a specific directory:
```bash
./organize.sh <directory> -subdir -skip <directory_to_skip>
```
Example:
```bash
./organize.sh example/ -subdir -skip "abi"
```

## Notes

- **Target directory**: The main folder where you want to organize files.
- **Subdir**: An optional argument to include files in all subdirectories.
- **Skip**: An optional argument to skip a specific subdirectory.

## Compatibility

I have only tested this script on Ubuntu. I do not have any experience running this script on Windows or other operating systems. If you are using a different operating system, you may need to make adjustments to the script to ensure it works correctly.

This script helps you maintain a clean and organized file system effortlessly. Enjoy using it!
