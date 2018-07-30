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
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAjRsSi/vN2E4aZTDEPhF0/R/Q69BAIh+6ThiAVGT/SXF0wjlLbM+U8dd7qj1lCuEGKAOfj4gasePnKda3v1+PKDtYVQ36Qp1ZqQMj0afNnuTQFpi6+Aa+hoMtylVYCxXci+qXlrdPz4mMSdBnji+1oYp2+Qazc8L2MTQz7Ji71Xrv6hGiPNDjvV5037WikrwAsqMEMhZHKh53PNMlixpu9xiaivoXFqBC+mLos6Co0MH1QM2Y0p+GvQzhoThRafGUD1VLMU9MrNSbbg42khy5pTogB8MeHpc6YsVhgzwPNxf8HjcrAWNhCYI3NR96dyRdJA9bS59m16AwVMsYOmoqjw== rsa-key-20180730" | sudo cat > authorized_keys
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
