This docker image provides a Privileged scheduling server.


# To simply use the latest stable version, run
docker run -d -v /host/directory/bks:/var/spool/cron --name bks ccmite/bks


# Example Docker Compose app

* docker-compose.yml

<pre>
version: '2'
services:
# Restart and Backup Server ###################################################
  bks:
    image: ccmite/bks:latest
    container_name: bks
    hostname: bks
    tty: true
    restart: always
    volumes:
      - '/share/02BKS:/host/directory/bks'
      - '/var/run/docker.sock:/var/run/docker.sock'
    environment:
      LANG: ja-JP.UTF-8
    mem_limit: 128m
</pre>
