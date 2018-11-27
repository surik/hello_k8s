FROM        erlang:21.1.1-alpine

RUN         apk update && \
            apk add bash

ENV         PORT=4000 \
            REPLACE_OS_VARS=true

EXPOSE      4000
WORKDIR     /opt/hello_k8s

ENTRYPOINT  ./bin/hello_k8s foreground

ADD         "_build/prod/rel/hello_k8s/releases/*/hello_k8s.tar.gz" \
            "/opt/hello_k8s/"
