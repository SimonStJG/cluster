FROM scratch

COPY ./bin/registry /registry
ADD config.yml /config.yml
VOLUME /data/registry
EXPOSE 5000
ENTRYPOINT [ "/registry" ]
CMD [ "serve", "/config.yml" ]
