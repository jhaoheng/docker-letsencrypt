FROM        nginx:1.15.5

# base
RUN         apt-get update && apt-get install -y vim procps cron

# install certbot
ARG         BACKPORTS="deb http://ftp.debian.org/debian stretch-backports main"
RUN         echo $BACKPORTS >> /etc/apt/sources.list
RUN         apt-get update && apt-get install python-certbot-nginx -t stretch-backports -y

# cron
RUN         service cron start