FROM alpine:3.12.0

ARG CURATOR_VERSION

RUN apk --update add python py-setuptools py-pip && \
    pip install elasticsearch-curator==${CURATOR_VERSION} && \
    apk del py-pip && \
    rm -rf /var/cache/apk/*

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
