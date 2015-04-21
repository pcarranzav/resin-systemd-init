#Base image
FROM resin/rpi-raspbian:jessie

RUN apt-get update && apt-get install -y sudo usbutils net-tools iputils-ping module-init-tools ifupdown 

# systemd configuration

ENV container lxc

# We never want these to run in a container
RUN systemctl mask \
    dev-hugepages.mount \
    dev-mqueue.mount \
    sys-fs-fuse-connections.mount \
    sys-kernel-config.mount \
    sys-kernel-debug.mount \

    display-manager.service \
    getty@.service \
    systemd-logind.service \
    systemd-remount-fs.service \

    getty.target \
    graphical.target
    

COPY entry.sh /usr/bin/entry.sh    
COPY launch.service /etc/systemd/system/launch.service
ENTRYPOINT ["/usr/bin/entry.sh"]

############## USER Dockerfile ###################

RUN apt-get update && apt-get install -y python libraspberrypi-bin

ENV INITSYSTEM "on"

COPY main.py /usr/src/app/main.py

CMD ["python", "/usr/src/app/main.py"]
