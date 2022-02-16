FROM fedora:35
RUN dnf install -y @workstation-product-environment @gnome dbus*
RUN dnf install -y langpacks-it

RUN systemctl disable gdm;\
    systemctl disable NetworkManager-wait-online.service

COPY startw /bin/startw

VOLUME [ "/home/student" ]
RUN useradd -G wheel student ;\
    echo "redhat" | passwd "student" --stdin ;\
    sed -i /etc/sudoers -r \
    -e 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' \
    -e 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' \
    -e 's/^%wheel.*/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/g'

CMD ["/sbin/init"]

