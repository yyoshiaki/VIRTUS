FROM ubuntu:latest
USER root

WORKDIR /workdir

COPY mkdir_star.sh /workdir

RUN chmod 777 mkdir_star.sh

ENV PATH $PATH:/workdir
