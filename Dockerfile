FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]

RUN mkdir -p /opt/coin
WORKDIR /opt/coin

RUN apt-get update && apt-get install -y wget python
RUN wget https://bitcoin.org/bin/bitcoin-core-22.0/bitcoin-22.0-x86_64-linux-gnu.tar.gz -O - | tar --strip-components 1 -C /opt/coin -xzf -

# cleanup
RUN apt remove -y wget && apt autoremove -y && apt autoclean
RUN rm -rf /var/lib/apt/lists/* /opt/coin/bin/{bitcoin-qt,test_bitcoin,bitcoin-wallet,bitcoin-tx}

ENTRYPOINT ["/opt/coin/bin/bitcoind"]
CMD ["-conf=/opt/coin/coin.conf"]
