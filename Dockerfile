FROM buildpack-deps:stretch as builder
ENV DEBIAN_FRONTEND=noninteractive DEBCONF_NOWARNINGS=yes
RUN apt-get update && apt-get -y install e2fslibs-dev
RUN VERSION=schily-2018-10-30 \
 && URL=https://sourceforge.net/projects/schilytools/files/$VERSION.tar.bz2/download \
 && wget -nv -O- --trust-server-names "$URL" | tar xfj - \
 && cd $VERSION \
 && make install

FROM debian:stretch-slim
COPY --from=builder /opt/schily/bin/* /usr/local/bin/
