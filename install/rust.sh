#! /usr/bin/env bash

command -v rustup >/dev/null 2>&1 && { echo "Rust installed, exiting."; exit 0; }

echo "Installing rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
