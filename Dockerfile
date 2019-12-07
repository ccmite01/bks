FROM debian:buster-slim
LABEL maintainer="ccmite"
WORKDIR /

RUN : "add package" && \
    apt --allow-releaseinfo-change update && apt install -y \
    locales \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg \
    cron \
    vim && \
    sed -i 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/g' /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8 && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" && \
    apt update --allow-releaseinfo-change && \
    apt install -y docker-ce=17.12.1~ce-0~debian && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    ln -s /var/spool/cron/.ssh /root/.ssh

COPY mcrcon /usr/bin/
RUN chmod +x /usr/bin/mcrcon
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENV MC_INSTANCE_NAME="paper" MC_SRVIP="jve" MC_SSH="/usr/bin/ssh" MC_SSHPORT="22" MC_USER="root" MC_RCON="/usr/bin/mcrcon" MC_RCONPORT="25575" MC_RCONPASS="SecretPassword"
ENTRYPOINT ["sh", "/entrypoint.sh"]

