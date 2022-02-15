FROM fedora:35
RUN dnf install -y @workstation-product-environment @gnome dbus*

RUN useradd -G wheel student 

RUN sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' -e 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' -e 's/^%wheel.*/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/g'

RUN echo "redhat" | passwd "student" --stdin
RUN echo "DISPLAY=:0 dbus-run-session -- gnome-shell --nested --wayland" > /usr/bin/startw && chmod +x /usr/bin/startw

RUN systemctl disable gdm
RUN systemctl disable NetworkManager-wait-online.service

VOLUME [ "/home/student" ]
#USER student

ENV MUTTER_DEBUG_DUMMY_MODE_SPECS=1400x700
ENV MUTTER_DEBUG_DUMMY_MONITOR_SCALES=1

CMD ["/sbin/init"]