FROM ubuntu:16.04
MAINTAINER examples@docker.com

RUN apt-get update && apt-get install -y openssh-server supervisor build-essential
RUN apt-get -y install vim git sudo
RUN mkdir -p /var/run/sshd /var/log/supervisor

RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

# add root ssh keys
RUN mkdir -p /root/.ssh
ADD https://github.com/nearffxx.keys /root/.ssh/authorized_keys

COPY install_requirements.sh /root/
RUN chmod 700 /root/install_requirements.sh
COPY build_android.sh /root/
RUN chmod 700 /root/build_android.sh

RUN /root/install_requirements.sh
RUN /root/build_android.sh

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22
CMD ["/usr/bin/supervisord"]
