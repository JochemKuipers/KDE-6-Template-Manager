#!/bin/bash

# region Shared constants

creator_icon="favorite"
editor_icon="edit"
eraser_icon="delete"
desktop_ext=".desktop"
bin_dir="$HOME/.bin/"

if [ "$(xdg-user-dir TEMPLATES)" != "$HOME" ]; then
    template_folder="$(xdg-user-dir TEMPLATES)"
else
    # Use XDG standard approach for KDE 6
    template_folder="$HOME/.local/share/templates"
    # Create the directory if it doesn't exist
    mkdir -p "$template_folder"
fi
template_src_folder="$template_folder/source"

# Use XDG standard approach for KDE 6 services
service_folder="$HOME/.local/share/kio/servicemenus"
# Create the directory if it doesn't exist
mkdir -p "$service_folder"

# endregion

# region Shared functions

function get_filename() # (filePath: str)
{
    basename -- "$1"
}

function get_filename_wo_extension() # (filePath: str)
{
    local filename
    filename="$(get_filename "$1")"
    if [ ! -d "$1" ]; then
        filename="${filename%.*}"
    fi
    printf "%s" "$filename"
}

function get_file_extension() # (filePath: str)
{
    local filename filename_wo_extension ext
    filename="$(get_filename "$1")"
    filename_wo_extension="$(get_filename_wo_extension "$1")"
    ext="${filename#$filename_wo_extension}"
    printf "%s" "$ext"
}

function get_template_desktop_path() # (templatePath: str)
{
    local path
    path="$template_folder/$(get_filename_wo_extension "$1")$desktop_ext"
    printf "%s" "$path"
}

# endregion
