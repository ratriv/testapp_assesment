FROM alpine
RUN apk add nginx; \
    mkdir /run/nginx/;

ADD $PWD/config/default.conf /etc/nginx/conf.d/default.conf

ADD $PWD/config/*.key /etc/ssl/private/
ADD $PWD/config/*.crt /etc/ssl/certs/

WORKDIR /var/www/localhost/htdocs

COPY $PWD/config/entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/bin/sh","/usr/local/bin/entrypoint.sh"]

EXPOSE 80
EXPOSE 443
CMD ["/bin/sh", "-c", "nginx -g 'daemon off;'; nginx -s reload;"]

