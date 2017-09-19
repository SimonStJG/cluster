FROM scratch

COPY ./bin/node_exporter /node_exporter

EXPOSE     9100
ENTRYPOINT [ "/node_exporter", \
		"--collector.procfs", "/host/proc", \
    "--collector.sysfs", "/host/sys", \
    "--collector.filesystem.ignored-mount-points", \
    "^/(sys|proc|dev|host|etc)($|/)"]
