#!/bin/bash

#docker pull debian:stable
docker build -t isaudits/templater-server .
#docker image prune -f