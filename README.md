# mosibi/mosquitto

Mosquitto
=========

Docker build file for mosquitto with TLS. This docker file is based on
Debian Jessie and mosquitto version 1.4.x. It will install Mosquitto a
APT repository (Debian packages) and uses 'generate-CA.sh' from
https://github.com/owntracks/tools to generate the TLS certificates.
The script generate-CA.sh is modified to let it accept custom values for
the email address, the organisation name and domain name.

Build from scratch
======
git clone https://github.com/Mosibi/mosquitto.git
cd mosquitto
docker build -t <yourname>/mosquitto .

Usage
======
docker run -d --net=host -t mosibi/mosquitto

Arguments
======

* -v /path/to/conf.d:/etc/mosquitto/conf.d

> Maps a directory from your docker host to the mosquitto container. Use this
> to make your TLS certificates and configuration persistent
>
> Add :z to the end of this argument when your docker host uses Selinux

Environment arguments
======

* FQDN

> The fully qualified domain name of that should be used in your certificate authority.
> If not set, it will default to the output from `hostname -f` in your container.

* EMAIL

> The email address that should be set in your server and root certificate. Defaults to
> nobody@example.net when not set.

* DOMAIN

> The domain name that should be set in your server and root certificate. Defaults to
> example.net when not set.

* IPLIST

> IP addresses that should be added to the subjAltName list
> Values must be white-space-separated

* HOSTLIST

> hostnames that should be added to the subjAltName list
> Values must be white-space-separated

Usage example
======

<pre><code>docker run -d --net=host \
	-e "FQDN=mqtt.example.com" \
	-e "EMAIL=me@example.com" \
	-e "DOMAIN=example.com" \
	-e "IPLIST=172.16.16.16 192.168.1.254" \
	-e "HOSTLIST=somehost.example.com docker.example.com" \
	-v /home/me/mosquitto/conf.d:/etc/mosquitto/conf.d:z \
	-t mosibi/mosquitto</code></pre>

See conf.d/mosquitto.conf for a config file example
