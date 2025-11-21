#! /usr/bin/env fish

# Disable fish greeting
set -U fish_greeting

if not contains jorgebucaran/fisher $_fisher_plugins
    # First set up
    set -U _fisher_plugins jorgebucaran/fisher
    fisher install IlanCosman/tide@v6
end

fisher update

# Tide config
tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No
set -U tide_right_prompt_items
set -U tide_left_prompt_items context pwd git cmd_duration character
