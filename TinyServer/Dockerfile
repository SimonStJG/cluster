FROM arm32v7/busybox

ADD ./www/index.html /www/index.html

EXPOSE 80

ENTRYPOINT [ "/bin/busybox" ]

CMD [ "httpd", "-f", "-p", "80", "-h", "/www" ]
