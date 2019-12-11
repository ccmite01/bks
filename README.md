This docker image provides a Privileged scheduling server.


# To simply use the latest stable version, run
docker run -d -v /opt/minecraft/backup:/var/spool/cron -v  /opt/minecraft/servers:/opt/minecraft -v /var/run/docker.sock:/var/run/docker.sock -v  /opt/docker-compose:/opt/docker-compose --name bks ccmite/bks


# Example Docker Compose app

* docker-compose.yml

<pre>
version: '2'
services:
# Restart and Cloud Backup Server ###################################################
  bks:
    image: ccmite/bks:latest
    container_name: bks
    hostname: bks
    tty: true
    restart: always
   
    volumes:
      - '/opt/minecraft/servers:/opt/minecraft'
      - '/opt/minecraft/backup:/var/spool/cron'
      - '/var/run/docker.sock:/var/run/docker.sock'
      - '/opt/docker-compose:/opt/docker-compose'
    environment:
      LANG: ja-JP.UTF-8
      MC_INSTANCE_NAME: paper
      MC_SRVIP: jve
      MC_SSH: /usr/bin/ssh
      MC_SSHPORT: 22
      MC_USER: root
      MC_RCON: /usr/bin/mcrcon
      MC_RCONPORT: 25575
      MC_RCONPASS: do_not_copy_and_paste
    mem_limit: 256m
</pre>
