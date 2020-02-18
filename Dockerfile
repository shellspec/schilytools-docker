FROM buildpack-deps:buster as builder
ENV DEBIAN_FRONTEND=noninteractive DEBCONF_NOWARNINGS=yes
RUN apt-get update && apt-get -y install e2fslibs-dev
RUN VERSION=schily-2020-02-11 \
 && URL=https://sourceforge.net/projects/schilytools/files/$VERSION.tar.bz2/download \
 && wget -nv -O- --trust-server-names "$URL" | tar xfj - \
 && cd $VERSION \
 && make install

FROM debian:buster-slim
COPY --from=builder /opt/schily/bin/* /usr/local/bin/
