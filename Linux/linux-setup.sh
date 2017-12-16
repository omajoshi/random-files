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
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAvV4JgFcnbCPJAPLGOCIsRCH6KHqsPC1idMMCnVWlaOVIRqSLwyn6j5JjK+EVtL4xw/4RSN4R4+OQ9Aik+s9vTlWLSn9lVQG5MOX8ydrY6IG1jf50BWIgSVQBmyE1srOnrlc/xfWO+YvXToDRkdoJEL0rPFSmmmt5EGmDMTHYFG3lHYjUavE9zhqHdE/6angVQZoeqP/PEdNioGTWTkgIaogJ2ArHdB816URPatwCwAYEKdbM+bnG4VA+XMbfcxnnzND4/2CdNKBEhEIJpBwaqBbytm06pEgAHU71hyWnZYPwJfS8fvy1L/zcpRhGR5QzF9dJp24TUUdyl6td2YnJIw== rsa-key-20171129" | sudo cat > authorized_keys
sudo chown $user:$user authorized_keys
sudo chmod 600 authorized_keys

# part 3
sudo perl -i -pe 's/.*/Port 8080/ if $.==13' /etc/ssh/sshd_config
sudo systemctl reload sshd

sudo ufw allow 8080
sudo ufw --force enable

# part 4
sudo apt install python3.7 -y
sudo ln -s /usr/local/bin/pip /usr/local/bin/pip3
sudo ln -s /usr/bin/python3.7 /usr/local/bin/python3
sudo ln -s /usr/bin/python3.7 /usr/local/bin/python
sudo ln -s /usr/bin/python3.7 /usr/local/bin/py

sudo apt install virtualenv

# part 5
sudo apt install mariadb-server -y

# part 6
sudo apt install tmux -y

# part 7
sudo apt install git -y
