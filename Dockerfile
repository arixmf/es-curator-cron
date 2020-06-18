FROM ubuntu:20.04

ARG CURATOR_VERSION

RUN apt-get update && \
	apt-get install -y python3 && \
	apt-get install -y python3-pip && \
	apt-get install -y curl && \
	apt-get -y install cron

RUN pip3 install elasticsearch-curator==${CURATOR_VERSION}

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
