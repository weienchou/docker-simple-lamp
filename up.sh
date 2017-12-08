eval $(docker-machine env --swarm father-0)

docker run -itd --name=www --net=family --env="constraint:node==father-0" httpd

docker run -it --rm --net=family --env="constraint:node==child-0" busybox wget -O- http://www

docker ps