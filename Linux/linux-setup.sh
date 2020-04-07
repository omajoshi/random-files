#!/bin/bash

# part 1 in the README file
user=${1?Need a username}
pw=${2?Need a password}

if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit 1
fi

curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash

sudo adduser --disabled-password --gecos "" $user
echo "$user:$pw" | sudo chpasswd
sudo usermod -aG sudo $user

# enable ssh key for the user, not just root
sudo install -d -o $user -g $user -m 700 /home/$user/.ssh/
cd /home/$user/.ssh/
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAoErgPvlJ+wsWp1yXJ1METBkqfQDdxQtg7KoaN5zfHQ1sOLgqAbwqnQqB4psjgQMtZljrjfJkFEvVtHnG6Qt2QGJghNpZQQdo9V28GDlbfO3dfO9dqn1EjEqU7xTqpwCxmr3P/sqCbzrAaWFq5mNMgv8xoa0A57Pb++Dx4oXgMw7Dq+cmCTT4bFODTcvkWrlUYcHFyuS1d4Mado607TsLX9/QHO+JgJFgyK3Snb8SkEwoVvuix1VYX75UGYRNnSy3pfI2z6roFa0i/s59WdwA+4UMeeldQN3XZMcN1/GUzN7Vsa7q8L6PWHFi/4DQ1UZqsP6sqMbEbh6ZJNR/diUuHQ== rsa-key-20180730" | sudo cat > authorized_keys
sudo chown $user:$user authorized_keys
sudo chmod 600 authorized_keys

# Don't do this anymore - we need 443 for nginx
# sudo perl -i -pe 's/.*/Port 443/ if $.==13' /etc/ssh/sshd_config
# sudo systemctl reload sshd

sudo apt update
sudo apt upgrade -y



sudo apt install virtualenv -y

sudo apt install nginx -y

sudo apt install tmux -y

sudo apt install git -y


sudo ufw allow ssh
sudo ufw allow 'Nginx Full'
sudo ufw --force enable

sudo apt install python3.8 -y
sudo ln -s -f /usr/bin/python3.8 /usr/local/bin/python3
sudo ln -s -f /usr/bin/python3.8 /usr/local/bin/python
sudo ln -s -f /usr/bin/python3.8 /usr/local/bin/py
