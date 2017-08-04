FROM docker pull docker

# Instaling Golang
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y -q curl build-essential ca-certificates git mercurial bzr
RUN mkdir /goroot && curl https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1
RUN mkdir /gopath

ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

# Intalling Postgres's Docker
RUN docker pull postgres:9.5.7 && \
    docker run --name robin-postgres -e POSTGRES_PASSWORD=root -d postgres:9.5.7 && \
    docker -it postgres-robin createdb robin && \
    docker exec -it postgres-robin psql -U postgres -d robin -c 'CREATE TABLE robin_base(ip INET PRIMARY KEY, total_probability REAL NOT NULL DEFAULT 0);'

# Setting up Robin's dependencies.
RUN go get github.com/lib/pq && \
    go get github.com/spf13/viper && \
    go get github.com/briandowns/spinner

# RUN mkdir $GOPATH/src/git.vpgrp.io
# WORKDIR $GOPATH/src/git.vpgrp.io
# RUN cp -rf /builds/vp-labs/robin-des-bots .
# WORKDIR $GOPATH/src/git.vpgrp.io/robin-des-bots
