#!/bin/bash

# shellcheck source=./TemplateManagerLocalization.sh
if [ -f "$HOME/.bin/TemplateManagerLocalization.sh" ]; then
    . "$HOME/.bin/TemplateManagerLocalization.sh"
else
    . "./TemplateManagerLocalization.sh"
fi
# shellcheck source=./TemplateManagerTools.sh
if [ -f "$HOME/.bin/TemplateManagerTools.sh" ]; then
    . "$HOME/.bin/TemplateManagerTools.sh"
else
    . "./TemplateManagerTools.sh"
fi

function cancel_operation()
{
    kdialog --error "$(str_cancel_operation)" --title "$(str_window_title)" --icon "$creator_icon"
    exit 1
}

function cannot_template()
{
    kdialog --error "$(str_cannot_template)" --title "$(str_window_title)" --icon "$creator_icon"
    exit 1
}

function exists_template_with_same_name()
{
    kdialog --error "$(str_exists_template_with_same_name)" --title "$(str_window_title)" --icon "$creator_icon"
}


# region Main

if [ "$#" -ne 1 ]; then
    printf "Error: Illegal number of parameters.\nUse: sh %s <file/directory>\n" "$0"
    exit 1
elif [ ! -d "$1" ] && [ ! -f "$1" ]; then
    cannot_template
fi

shortname="$(get_filename_wo_extension "$1")"

if ! template_name=$(kdialog --inputbox "$(str_get_name)" "$shortname" --title "$(str_window_title)" --icon "$creator_icon" --geometry 450x300); then
    cancel_operation
elif [ -z "${template_name// /}" ]; then
    template_name=$shortname
elif does_template_exist_with_same_name "" "$template_name"; then
    exists_template_with_same_name
fi

if ! template_comment=$(kdialog --inputbox "$(str_get_comment)" --title "$(str_window_title)" --icon "$creator_icon"); then
    cancel_operation
fi

if ! template_icon=$(kdialog --geticon MimeType --title "$(str_window_title)" --icon "$creator_icon"); then
    cancel_operation
fi

template_url="$template_src_folder/$template_name$(get_file_extension "$1")"
/bin/cp -r "$1" "$template_url"

printf "[Desktop Entry]
Name=%s
Comment=%s
Type=Link
URL=%s
Icon=%s" "$template_name" "$template_comment" "$template_url" "$template_icon" > "$template_folder/$template_name$desktop_ext"

kdialog --msgbox "$(str_created_template)'$template_name'." --title "$(str_window_title)" --icon "$creator_icon"

# endregion
