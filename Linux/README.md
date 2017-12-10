Linux Setup Script
===
To be used with a new Linux server

Instructions
---
1. Download this script
2. `chmod +x linux-setup.sh`
3. `sudo ./linux-setup.sh {username goes here} {password goes here}`

Script Contents
---
1. Adds a password-protected sudo user (user and password passed as bash args)
2. Creates a folder `~/ssh` to allow a specific SSH key to remotely connect
3. Changes SSH port to `8080` and activates a firewall that blocks all but 8080
4. Installs Python3.7 and sets it as the default `python`, `py`, and `python3`
5. Installs `tmux` for running multiple terminal windows at once
