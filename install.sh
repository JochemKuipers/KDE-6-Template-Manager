#!/bin/bash

. ./TemplateManagerTools.sh
. ./TemplateManagerLocalization.sh

mkdir -p "$bin_dir"
mkdir -p "$template_src_folder"

/bin/cp "./TemplateCreator.sh" "$bin_dir"
/bin/cp "./TemplateEditor.sh" "$bin_dir"
/bin/cp "./TemplateEraser.sh" "$bin_dir"
/bin/cp "./TemplateManagerLocalization.sh" "$bin_dir"
/bin/cp "./TemplateManagerTools.sh" "$bin_dir"
chmod +x "$bin_dir/TemplateCreator.sh"
chmod +x "$bin_dir/TemplateEditor.sh"
chmod +x "$bin_dir/TemplateEraser.sh"
chmod +x "$bin_dir/TemplateManagerLocalization.sh"
chmod +x "$bin_dir/TemplateManagerTools.sh"

# Copy wrapper scripts to service folder
/bin/cp "./template-creator-wrapper.sh" "$service_folder"
/bin/cp "./template-editor-wrapper.sh" "$service_folder"
/bin/cp "./template-eraser-wrapper.sh" "$service_folder"
chmod +x "$service_folder/template-creator-wrapper.sh"
chmod +x "$service_folder/template-editor-wrapper.sh"
chmod +x "$service_folder/template-eraser-wrapper.sh"

/bin/cp "./TemplateManager_File.desktop" "$service_folder"
/bin/cp "./TemplateManager_Dir.desktop" "$service_folder"
chmod +x "$service_folder/TemplateManager_File.desktop"
chmod +x "$service_folder/TemplateManager_Dir.desktop"

kdialog --msgbox "$(str_installed)" --title "$(str_window_title)" --icon "$creator_icon" 2>/dev/null
