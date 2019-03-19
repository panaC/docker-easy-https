FROM nginx:1.15
LABEL maintainer="github.com/panaC"

COPY server.conf /etc/nginx/conf.d/server.conf

RUN apt-get update && \
    apt-get install certbot -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD entrypoint.sh .

ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]