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
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBrqqYM+Ff3KSTrBeVhmVQgN+R3PjwniVyjQQxWbHjBR om@omajoshi.com" | sudo cat > authorized_keys
sudo chown $user:$user authorized_keys
sudo chmod 600 authorized_keys


sudo wget -O /home/$user/ascii-art.ans https://raw.githubusercontent.com/omajoshi9/random-files/master/Linux/ascii-art.ans
printf '#!/bin/sh\n\nbash /home/%s/motd.sh\n' "$user" | sudo tee /etc/update-motd.d/15-welcome-screen > /dev/null
sudo chmod +x /etc/update-motd.d/15-welcome-screen
printf '\ncat /home/%s/ascii-art.ans' "$user" | sudo tee /home/$user/motd.sh
printf 'set tabsize 4\nset tabstospaces\n' | tee /home/$user/.nanorc


sudo apt install virtualenv -y

sudo apt install nginx -y

sudo apt install tmux -y

sudo apt install git -y

sudo add-apt-repository -r ppa:certbot/certbot

sudo apt install python-certbot-nginx -y

sudo ufw allow 'OpenSSH'
sudo ufw allow 'Nginx Full'
sudo ufw --force enable

sudo apt install python3.8 -y
sudo ln -s -f /usr/bin/python3.8 /usr/local/bin/python3
sudo ln -s -f /usr/bin/python3.8 /usr/local/bin/python
sudo ln -s -f /usr/bin/python3.8 /usr/local/bin/py


sudo apt update
sudo apt upgrade -y
