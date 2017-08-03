FROM golang:1.8.3

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        docker.io

# Docker Postgres
RUN docker pull postgres:9.5.7 && \
    docker run --name robin-postgres -e POSTGRES_PASSWORD=root -d postgres:9.5.7
RUN docker exec -it postgres-robin psql -U postgres -d robin -c 'CREATE TABLE robin_base(ip INET PRIMARY KEY, total_probability REAL NOT NULL DEFAULT 0);'s

# Setting up Robin
RUN go get github.com/lib/pq
RUN go get github.com/spf13/viper
RUN go get github.com/briandowns/spinner

# RUN mkdir $GOPATH/src/git.vpgrp.io
# WORKDIR $GOPATH/src/git.vpgrp.io
# RUN cp -rf /builds/vp-labs/robin-des-bots .
# WORKDIR $GOPATH/src/git.vpgrp.io/robin-des-bots
