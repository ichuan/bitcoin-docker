FROM ubuntu:19.04

RUN mkdir -p /opt/coin
WORKDIR /opt/coin

EXPOSE 8332

RUN apt-get update && apt-get install -y wget python
RUN wget https://bitcoincore.org/bin/bitcoin-core-0.19.0.1/bitcoin-0.19.0.1-x86_64-linux-gnu.tar.gz -O - | tar --strip-components 1 -C /opt/coin -xzf -

# cleanup
RUN apt remove -y wget unzip && apt autoremove -y && apt autoclean
RUN rm -rf /var/lib/apt/lists/* /opt/coin/bin/{bitcoin-qt,test_bitcoin,bitcoin-wallet,bitcoin-tx}

VOLUME ["/opt/coin/data", "/opt/coin/coin.conf"]

ENTRYPOINT ["/opt/coin/bin/bitcoind"]
CMD ["-conf=/opt/coin/coin.conf"]
