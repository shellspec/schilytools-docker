FROM buildpack-deps:buster as builder
ENV DEBIAN_FRONTEND=noninteractive DEBCONF_NOWARNINGS=yes
RUN apt-get update && apt-get -y install e2fslibs-dev
RUN VERSION=schily-2019-09-22 \
 && URL=https://sourceforge.net/projects/schilytools/files/$VERSION.tar.bz2/download \
 && wget -nv -O- --trust-server-names "$URL" | tar xfj - \
 && cd $VERSION \
 && mv bsh/dotfiles.bsh.tar.bz2 bsh/dotfiles.tar.bz2 \
 && mv ved/dotfiles.ved.tar.bz2 ved/dotfiles.tar.bz2 \
 && make install

FROM debian:buster-slim
COPY --from=builder /opt/schily/bin/* /usr/local/bin/
