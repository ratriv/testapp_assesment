FROM alpine
RUN apk add nginx; \
    mkdir /run/nginx/; \
    echo "<h1>This is  Testapp.... Rahul Trivedi</h1>" > /var/www/localhost/htdocs/index.html;

ADD $PWD/config/default.conf /etc/nginx/conf.d/default.conf

ADD $PWD/config/*.key /etc/ssl/private/
ADD $PWD/config/*.crt /etc/ssl/certs/

WORKDIR /var/www/localhost/htdocs

COPY $PWD/config/entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/bin/sh","/usr/local/bin/entrypoint.sh"]

CMD ["/bin/sh", "-c", "nginx -g 'daemon off;'; nginx -s reload;"]
