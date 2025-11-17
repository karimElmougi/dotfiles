#! /usr/bin/env fish

# Disable fish greeting
set -U fish_greeting

set -U _fisher_plugins jorgebucaran/fisher

fisher update
fisher install IlanCosman/tide@v6

# Tide config
set -U tide_right_prompt_items
set -U tide_left_prompt_items context pwd git cmd_duration character
