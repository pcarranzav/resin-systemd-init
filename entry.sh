#!/bin/bash

env > /etc/docker.env

echo -e "#!/bin/bash\n exec $@" > /etc/docker.cmd
chmod +x /etc/docker.cmd

systemctl enable /etc/systemd/system/launch.service

exec /sbin/init