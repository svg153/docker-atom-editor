FROM ubuntu:latest


RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      fakeroot \
      gconf2 \
      gconf-service \
      git \
      gvfs-bin \
      libasound2 \
      libcap2 \
      libgconf-2-4 \
      libgtk2.0-0 \
      libnotify4 \
      libnss3 \
      libxkbfile1 \
      libxss1 \
      libxtst6 \
      libgl1-mesa-glx \
      libgl1-mesa-dri \
      python \
      xdg-utils

# other deps to rebuild packages
RUN apt-get install -y \
      build-essential



#
# clean
#
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*



#
# sshd
#

#ENV ROOTPASSWORD atom

#EXPOSE 22

#RUN apt-get install -y \
#    ssh \
#    openssh-server \
#    openssh-client \
#    net-tools \
#    socat

#RUN mkdir -p /var/run/sshd && \
#  echo "root:${ROOTPASSWORD}" | chpasswd && \
#  sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
#  sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
#  echo "export VISIBLE=now" >> /etc/profile

#CMD ["/usr/sbin/sshd"]



#
# atom
#

RUN curl -L https://atom.io/download/deb > /tmp/atom.deb && \
    dpkg --install /tmp/atom.deb && \
    apm upgrade --confirm false && \
    rm -f /tmp/atom.deb && \
    useradd -d /home/atom -m atom

# Run atom as atom user
USER atom
CMD ["/usr/bin/atom","-f"]
