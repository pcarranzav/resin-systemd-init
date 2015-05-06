
echo "Hellooo"
# Make sudo actually work
HOSTNAME=$(cat /etc/hostname)
echo "127.0.1.1 $HOSTNAME" >> /etc/hosts
hostname $HOSTNAME

modprobe i2c-dev

python /usr/src/app/main.py