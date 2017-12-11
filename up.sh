#!/bin/bash
eval $(docker-machine env --swarm father-0)

docker-compose up -d

#docker run -itd \
#	-v $(pwd)/www:/var/www/yotta \
#	-w /var/www/yotta \
#	--name=www \
#	--net=family \
#	--env="constraint:node==child-0" httpd

# docker run -it --rm \
# 	--net=family \
# 	--env="constraint:node==child-0" busybox wget -O- http://www

# php
# docker service create \
#     --name php \
#     -e MYSQL_PASSWORD=sPes4uBrEcHUq5qE \
#     --network family \
#     php:5.6.32

# mysql
# docker service create \
#     --name mysql \
#     -e TZ=Asia/Shanghai \
#     -e MYSQL_ROOT_PASSWORD=sPes4uBrEcHUq5qE \
#     --mount src=mysql-data,dst=/var/lib/mysql \
#     --network family \
#     mysql:5.7 \
#     mysqld --character-set-server=utf8

# apache
# docker service create  \
# 	--mode global \
# 	--name httpd \
# 	--network family \
# 	--publish mode=host,target=80,published=80 \
# 	httpd

docker ps

# docker service ls