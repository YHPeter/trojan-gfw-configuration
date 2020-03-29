#!/bin/bash

# Written by YHPeter

# Kill all running instances
pgrep trojan && killall trojan

# Change to the executable's local directory
cd "$(dirname "$0")"

# Run Trojan with specified config
./trojan
