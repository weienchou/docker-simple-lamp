#!/bin/bash

docker-machine rm -y mother-0 || true
docker-machine rm -y father-0 || true
docker-machine rm -y child-0 || true
docker-machine rm -y child-1 || true