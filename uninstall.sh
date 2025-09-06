#!/bin/bash

. ./TemplateManagerTools.sh
. ./TemplateManagerLocalization.sh

# Remove template source folder if it exists and is empty
if [ -d "$template_src_folder" ]; then
    rmdir "$template_src_folder" 2>/dev/null || rm -rf "$template_src_folder"
fi

# Remove script files if they exist
[ -f "$bin_dir/TemplateCreator.sh" ] && rm "$bin_dir/TemplateCreator.sh"
[ -f "$bin_dir/TemplateEditor.sh" ] && rm "$bin_dir/TemplateEditor.sh"
[ -f "$bin_dir/TemplateEraser.sh" ] && rm "$bin_dir/TemplateEraser.sh"
[ -f "$bin_dir/TemplateManagerLocalization.sh" ] && rm "$bin_dir/TemplateManagerLocalization.sh"
[ -f "$bin_dir/TemplateManagerTools.sh" ] && rm "$bin_dir/TemplateManagerTools.sh"

# Remove bin directory if it exists and is empty
if [ -d "$bin_dir" ]; then
    rmdir "$bin_dir" 2>/dev/null || rm -rf "$bin_dir"
fi

# Remove service menu files if they exist
[ -f "$service_folder/TemplateManager_File.desktop" ] && rm "$service_folder/TemplateManager_File.desktop"
[ -f "$service_folder/TemplateManager_Dir.desktop" ] && rm "$service_folder/TemplateManager_Dir.desktop"

# Ask user if they want to remove existing templates
if kdialog --warningyesno "$(str_uninstall_confirmation_msg)" --title "$(str_window_title)" --icon "$creator_icon" 2>/dev/null; then
    if [ -d "$template_folder" ] && [ "$(ls -A "$template_folder" 2>/dev/null)" ]; then
        rm -rf "$template_folder"/*
    fi
fi

kdialog --msgbox "$(str_uninstalled)" --title "$(str_window_title)" --icon "$creator_icon" 2>/dev/null
