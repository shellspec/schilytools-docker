FROM buildpack-deps:buster as builder
ENV DEBIAN_FRONTEND=noninteractive DEBCONF_NOWARNINGS=yes
RUN apt-get update && apt-get -y install build-essential libacl1-dev libattr1-dev libcap-dev libelf-dev libexpat1-dev libext2fs-dev linux-headers-amd64
ENV VERSION=schily-2022-10-16
ENV URL=https://codeberg.org/attachments/466da49b-ec23-4eb1-84eb-743f8cd1db22
RUN wget -nv -O- --trust-server-names "$URL" | tar xfj -
WORKDIR $VERSION
RUN make install
RUN /opt/schily/bin/bosh -c 'echo ${.sh.version}'

FROM debian:buster-slim
COPY --from=builder /opt/schily/bin/* /usr/local/bin/
