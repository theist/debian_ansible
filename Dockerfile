FROM debian
MAINTAINER Carlos Peñas
RUN apt-get -y update
RUN apt-get install -y python-dev python-pip libffi-dev python-setuptools pypy-lib libyaml-dev libgnutls-openssl-dev libssl-dev systemd
RUN pip install cffi --upgrade
RUN pip install cryptography --upgrade
RUN pip install ansible
RUN cd /lib/systemd/system/sysinit.target.wants/; ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*; \
rm -f /lib/systemd/system/plymouth*; \
rm -f /lib/systemd/system/systemd-update-utmp* \
rm -f /lib/systemd/system/tmp.mount \
rm -f /lib/systemd/system/systemd-tmpfiles-clean.timer;
RUN systemctl set-default multi-user.target
ENV init /lib/systemd/systemd
VOLUME [ "/sys/fs/cgroup" ]

COPY ansible_and_bash.sh /ansible_and_bash.sh
RUN chmod a+x /ansible_and_bash.sh
CMD /ansible_and_bash.sh
