FROM nimmis/golang:1.6.2

RUN apt-get update -y & \
    apt-get install -y apt-transport-https

# Installing Docker.
RUN echo "deb http://get.docker.io/ubuntu docker main" >> /etc/apt/sources.list.d/docker.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 && \
    apt-get update -y && \
    apt-get install -y lxc-docker && \
    su -l root service docker start

# Intalling Postgres's Docker
RUN su -l root docker pull postgres:9.5.7 && \
    su -l root docker run --name robin-postgres -e POSTGRES_PASSWORD=root -d postgres:9.5.7 && \
    su -l root docker -it postgres-robin createdb robin
    su -l root docker exec -it postgres-robin psql -U postgres -d robin -c 'CREATE TABLE robin_base(ip INET PRIMARY KEY, total_probability REAL NOT NULL DEFAULT 0);'

# Setting up Robin's dependencies.
RUN go get github.com/lib/pq && \
    go get github.com/spf13/viper && \
    go get github.com/briandowns/spinner

# RUN mkdir $GOPATH/src/git.vpgrp.io
# WORKDIR $GOPATH/src/git.vpgrp.io
# RUN cp -rf /builds/vp-labs/robin-des-bots .
# WORKDIR $GOPATH/src/git.vpgrp.io/robin-des-bots
