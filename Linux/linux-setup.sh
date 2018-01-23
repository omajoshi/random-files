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
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAlaK+wfTVmeLS3MlfHoUUFDQEj+O5hgLWUJXbBxtjhQ5YZ+AgZ2jd+m9JNoKeXPh42Q0s7P9SV/KsKppxP9HBKLs8umaTNPy5Q3+p6GkEzCEuAPUTeFwmALArnhZ3/Vdid1zbLtRVRwdHkNc+iZKFmUtCDkZSIYAYOA96C25w2qT9pnS+hUERlH02hWUwauln8JjVpqQgihs6dopaZ0yCIOMQ4r4IGi6O0HBYOIMompWRX7iTR7f3H8Dz76M/sRs80dhCRs9GzedPxVg+q75MECDoejewwb5OfozCln6bucyC8YfsYYpmKl/nMP/VFp+HPNV+JG8rqq7fkVhMIjeqxw== rsa-key-20171220" | sudo cat > authorized_keys
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
