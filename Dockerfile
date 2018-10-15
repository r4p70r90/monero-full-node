# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/root/.bitmonero -p 18080:18080 -p 18081:18081 --name=monerod -td r4p70r90/monero-full-node
FROM ubuntu:16.04

ENV MONERO_VERSION=0.13.0.2 MONERO_SHA256=a59fc0fffb325b4f92a5b500438bf340ddbf78e91581eb4df95ad2d5e5fb42a8

RUN apt-get update && apt-get install -y curl wget bzip2 libpcsclite-dev

# RUN useradd -ms /bin/bash monero
# USER monero
# WORKDIR /home/monero
WORKDIR /root

RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v$MONERO_VERSION.tar.bz2 -O &&\
  echo "$MONERO_SHA256  monero-linux-x64-v$MONERO_VERSION.tar.bz2" | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  rm monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  cp ./monero-v$MONERO_VERSION/monerod . &&\
  rm -r monero-* &&\
  wget -P /root/.bitmonero/ https://raw.githubusercontent.com/r4p70r90/monero-full-node/master/bitmonero.conf

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18080:18080 18089:18089

ENTRYPOINT ["./monerod"]
CMD ["--config-file=/root/.bitmonero/bitmonero.conf --confirm-external-bind --check-updates disabled"]
