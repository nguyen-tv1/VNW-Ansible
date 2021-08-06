#!/bin/bash
apt update
apt-get install -y libpython-stdlib python python-minimal resolvconf
apt-get install -y gnupg git
apt-get install -y libffi-dev python-dev libevent-dev
user=nguyentv
authkey="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBDDivdBpMGfjmjxePSlZNXjcJvZmc7IJ/xP7BgdPhrL nguye@DESKTOP-TD8ECB4"
#if [ ! $(cat /etc/passwd|grep ^${user}) ]; then
useradd $user
mkdir -p /home/${user}/.ssh
touch /home/${user}/.ssh/authorized_keys
echo ${authkey} >> /home/${user}/.ssh/authorized_keys
cp /root/.bashrc /home/${user}
cp /root/.profile /home/${user}
chown -R $user:$user /home/$user
echo -e "1qaz2wsx\n1qaz2wsx" | passwd $user
#sed -i "s#$(cat /etc/passwd|grep ^${user})#$(cat /etc/passwd|grep ^${user})\/bin\/bash#g" /etc/passwd
usermod -aG sudo ${user}
#fi

# change /etc/sudoers
chmod 775 /etc/sudoers
SUDO_STRAF="%sudo ALL=(ALL:ALL) NOPASSWD:ALL"
SUDO_STRBE=$(cat /etc/sudoers |grep "^%sudo")

if [ $? -ne 0 ]; then
echo $SUDO_STRAF >> /etc/sudoers
else
sed -i "s#$SUDO_STRBE#$SUDO_STRAF#g" /etc/sudoers
fi
chmod 440 /etc/sudoers
