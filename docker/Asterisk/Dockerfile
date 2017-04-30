FROM debian:jessie
MAINTAINER Jacob Andresen <jacob.andresen@gmail.com>
ENV build_date 2017-04-31

ENV ASTERISKUSER asterisk
ENV ASTERISKVER 14.4.0

RUN groupadd -r $ASTERISKUSER && useradd -r -g $ASTERISKUSER $ASTERISKUSER \
	&& mkdir /var/lib/asterisk && chown $ASTERISKUSER:$ASTERISKUSER /var/lib/asterisk \
	&& usermod --home /var/lib/asterisk $ASTERISKUSER

RUN apt-get update && apt-get install -y uuid-dev build-essential libxml2-dev libncurses5-dev \
					libsqlite3-dev libssl-dev libxslt-dev libjansson-dev

WORKDIR /tmp
RUN mkdir src && cd src \
	&& apt-get install -y wget \
	&& wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-$ASTERISKVER.tar.gz \
	&& tar -xvzf asterisk-$ASTERISKVER.tar.gz

WORKDIR /tmp/src/asterisk-$ASTERISKVER
RUN  ./configure
RUN  cd menuselect && make menuselect && cd .. & make menuselect-tree
RUN  menuselect/menuselect --disable BUILD_NATIVE menuselect/menuselect.makeopts 
RUN  make && make install && make config

RUN chown -R $ASTERISKUSER:$ASTERISKUSER /var/lib/asterisk \
	&& chown -R $ASTERISKUSER:$ASTERISKUSER /var/spool/asterisk \
	&& chown -R $ASTERISKUSER:$ASTERISKUSER /var/log/asterisk \
	&& chown -R $ASTERISKUSER:$ASTERISKUSER /var/run/asterisk \
	&& chown -R $ASTERISKUSER:$ASTERISKUSER /etc/asterisk

VOLUME /var/log/asterisk
VOLUME /etc/asterisk
VOLUME /var/lib/asterisk

EXPOSE 5060

WORKDIR /var/lib/asterisk
USER $ASTERISKUSER

CMD ["/usr/sbin/asterisk","-f"]
