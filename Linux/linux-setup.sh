#!/bin/bash

# part 1 in the README file
user=${1?Need a username}
pw=${2?Need a password}

if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit 1
fi

sudo adduser --disabled-password --gecos "" $user
echo "$user:$pw" | sudo chpasswd
sudo usermod -aG sudo $user

# part 2 in the README file
sudo install -d -o $user -g $user -m 700 /home/$user/.ssh/
cd /home/$user/.ssh/
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAoErgPvlJ+wsWp1yXJ1METBkqfQDdxQtg7KoaN5zfHQ1sOLgqAbwqnQqB4psjgQMtZljrjfJkFEvVtHnG6Qt2QGJghNpZQQdo9V28GDlbfO3dfO9dqn1EjEqU7xTqpwCxmr3P/sqCbzrAaWFq5mNMgv8xoa0A57Pb++Dx4oXgMw7Dq+cmCTT4bFODTcvkWrlUYcHFyuS1d4Mado607TsLX9/QHO+JgJFgyK3Snb8SkEwoVvuix1VYX75UGYRNnSy3pfI2z6roFa0i/s59WdwA+4UMeeldQN3XZMcN1/GUzN7Vsa7q8L6PWHFi/4DQ1UZqsP6sqMbEbh6ZJNR/diUuHQ== rsa-key-20180730" | sudo cat > authorized_keys
sudo chown $user:$user authorized_keys
sudo chmod 600 authorized_keys

# part 3
# Don't do this anymore - we need 443 for nginx
# sudo perl -i -pe 's/.*/Port 443/ if $.==13' /etc/ssh/sshd_config
# sudo systemctl reload sshd

# part 4
sudo apt update
sudo apt upgrade -y
sudo apt install python3.8 -y
sudo ln -s -f /usr/bin/pip /usr/local/bin/pip3
sudo ln -s -f /usr/bin/python3.8 /usr/local/bin/python3
sudo ln -s -f /usr/bin/python3.8 /usr/local/bin/python
sudo ln -s -f /usr/bin/python3.8 /usr/local/bin/py

sudo apt install virtualenv -y

# part 5
sudo apt install nginx -y

# part 6
sudo apt install tmux -y

# part 7
sudo apt install git -y


sudo ufw allow sshd
sudo ufw allow Nginx Full
sudo ufw --force enable
