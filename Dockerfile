FROM buildpack-deps:buster as builder
ENV DEBIAN_FRONTEND=noninteractive DEBCONF_NOWARNINGS=yes
RUN apt-get update && apt-get -y install e2fslibs-dev
ENV VERSION=schily-2020-09-04
ENV URL=https://sourceforge.net/projects/schilytools/files/$VERSION.tar.bz2/download
RUN wget -nv -O- --trust-server-names "$URL" | tar xfj -
WORKDIR $VERSION
RUN make install
RUN /opt/schily/bin/bosh -c 'echo ${.sh.version}'

FROM debian:buster-slim
COPY --from=builder /opt/schily/bin/* /usr/local/bin/
