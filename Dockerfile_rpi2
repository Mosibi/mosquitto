FROM armbuild/debian:jessie

MAINTAINER Richard Arends <richard@mosibi.nl>

ENV LC_ALL "C.UTF-8"
ENV LANG "C.UTF-8"

# Configure no init scripts to run on package updates.
ADD files/policy-rc.d /usr/sbin/policy-rc.d
RUN chmod 755 /usr/sbin/policy-rc.d

WORKDIR /tmp
RUN apt-get update && \
    apt-get install -y curl && \
    curl -O http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key && \
    apt-key add mosquitto-repo.gpg.key && \
    rm mosquitto-repo.gpg.key

WORKDIR /etc/apt/sources.list.d/
RUN curl -O http://repo.mosquitto.org/debian/mosquitto-$(awk -F"[)(]+" '/VERSION=/ {print $2}' /etc/os-release).list

RUN apt-get update && \
    apt-get install -y mosquitto \
	mosquitto-clients \
	&& rm -rf /var/lib/apt/lists/*

# COPY files
COPY files/generate-CA.sh /usr/local/bin/generate-CA.sh
RUN chmod 755 /usr/local/bin/generate-CA.sh
COPY files/init.sh /init.sh
RUN chmod 755 /init.sh
WORKDIR /etc/mosquitto/conf.d

# MQTT ports
EXPOSE 1883
EXPOSE 8883

CMD [ "/init.sh" ]
