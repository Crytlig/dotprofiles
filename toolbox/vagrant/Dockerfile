FROM debian:bullseye-slim

ENV	VAGRANT_VERSION 2.2.14+dfsg-1

RUN	apt-get update && apt-get install -y \
	bridge-utils \
	ca-certificates \
	curl \
	gcc \
	make \
	pkg-config \
	ruby-dev \
	ssh \
	zlib1g-dev \
	vagrant=${VAGRANT_VERSION} \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*



# install the libvirt plugin
# RUN vagrant plugin install vagrant-libvirt vagrant-nixos-plugin
RUN vagrant plugin install vagrant-nixos-plugin

ENTRYPOINT [ "bash" ]
