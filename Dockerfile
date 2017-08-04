FROM ubuntu
MAINTAINER Anis BENNABI <abennabi@epitech.eu>

RUN apt-get update -y

# Golang
RUN apt-get install --no-install-recommends -y -q curl build-essential ca-certificates git mercurial bzr
RUN mkdir /goroot && curl https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1
RUN mkdir /gopath

ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN mkdir $GOPATH/bin $GOPATH/pkg $GOPATH/src $GOPATH/src/git.vpgrp.io
WORKDIR $GOPATH/src/git.vpgrp.io/robin-des-bots

# Setting up Robin's dependencies.
RUN go get github.com/lib/pq && \
    go get github.com/spf13/viper && \
    go get github.com/briandowns/spinner

# Postgres
RUN apt-get install --no-install-recommends -y -q postgresql-9.5
RUN createdb -U postgres robin && \
    psql -U postgres -d robin -c 'CREATE TABLE robin_base(ip INET PRIMARY KEY, total_probability REAL NOT NULL DEFAULT 0);'
