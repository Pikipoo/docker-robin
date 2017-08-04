FROM nimmis/golang:1.6.2

# Docker.
RUN echo "deb http://get.docker.io/ubuntu docker main" >> /etc/apt/sources.list.d/docker.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN apt-get update -y
RUN apt-get install -y lxc-docker
RUN service docker start

# Docker Postgres
RUN docker pull postgres:9.5.7
RUN docker run --name robin-postgres -e POSTGRES_PASSWORD=root -d postgres:9.5.7
RUN docker exec -it postgres-robin psql -U postgres -d robin -c 'CREATE TABLE robin_base(ip INET PRIMARY KEY, total_probability REAL NOT NULL DEFAULT 0);'

# Setting up Robin
RUN go get github.com/lib/pq
RUN go get github.com/spf13/viper
RUN go get github.com/briandowns/spinner

# RUN mkdir $GOPATH/src/git.vpgrp.io
# WORKDIR $GOPATH/src/git.vpgrp.io
# RUN cp -rf /builds/vp-labs/robin-des-bots .
# WORKDIR $GOPATH/src/git.vpgrp.io/robin-des-bots
