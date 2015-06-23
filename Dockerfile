# sshd
#
# VERSION               0.0.1

FROM ubuntu:14.04
MAINTAINER Jesse Fugitt

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# This sets the root password to "root" and enables password login for root; comment out to disable
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# This copies over any authorized keys for password-less login; comment out to disable
ADD authorized_keys /authorized_keys
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
RUN mv /authorized_keys /root/.ssh/.
RUN chmod 600 /root/.ssh/*
RUN chown -Rf root:root /root/.ssh

# Allow reverse tunnels
RUN echo '\nGatewayPorts clientspecified\n' >> /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

