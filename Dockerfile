FROM alpine:3.9.4 as build

WORKDIR /opt/notify-forwarder

RUN set +x && apk add --no-cache \
    make \
    g++

COPY . /opt/notify-forwarder/

RUN make

FROM alpine:3.9.4

RUN set +x && apk add --no-cache \
    libgcc \
    libstdc++

COPY --from=build /opt/notify-forwarder/_build/notify-forwarder /usr/local/bin/notify-forwarder

CMD ["notify-forwarder", "receive"]
