#!/bin/bash

# part 1 in the README file
user=${1?Need a username}
pw=${2?Need a password}

if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit
fi

sudo adduser --disabled-password --gecos "" $user
echo "$user:$pw" | sudo chpasswd
sudo usermod -aG sudo $user

# part 2 in the README file
sudo install -d -o $user -g $user -m 700 /home/$user/.ssh/
cd /home/$user/.ssh/
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAwIgREsEKFztc41QZXu2hSEJ8Og2+AwRtHf005LvgjL12YRufr8f9MjK4lpB2mUuq7Ko35t5eInkV/O1/kB7i9R5ikOIW+JT9iWSJTNijrodNQQe6l9koB8X5c+fm849Zqo2EDxZd5p9E2vg/Cv/QTIhoFDpYIayt1QvYAtVoyjyd9u7KiMbLwcI5ZGy35U8IwpFupy0ymI1iAtlKv/PFBdUH8Q/E62V+f0wK/5HlUu8QcAHqLH9uIFlcKYhJifIXbu+haynGRhAH9NEKe6dw7ReekOeWwwH+YhyptIoXRO1gJqiH98Ur+4+PNnjv4Be2nkQmOe8cWHoghUnDnecmow== rsa-key-20180730" | sudo cat > authorized_keys
sudo chown $user:$user authorized_keys
sudo chmod 600 authorized_keys

# part 3
sudo perl -i -pe 's/.*/Port 443/ if $.==13' /etc/ssh/sshd_config
sudo systemctl reload sshd

sudo ufw allow 443
sudo ufw --force enable

# part 4
sudo apt install python3.7 -y
sudo ln -s /usr/local/bin/pip /usr/local/bin/pip3
sudo ln -s /usr/bin/python3.7 /usr/local/bin/python3
sudo ln -s /usr/bin/python3.7 /usr/local/bin/python
sudo ln -s /usr/bin/python3.7 /usr/local/bin/py

sudo apt install virtualenv -y

# part 5
sudo apt install nginx -y

# part 6
sudo apt install tmux -y

# part 7
sudo apt install git -y
