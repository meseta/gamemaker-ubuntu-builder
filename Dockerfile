FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --no-install-recommends --yes \
	curl \
	gnupg \
	ca-certificates \
	build-essential \
	openssh-server \
	clang \
	libssl-dev \
	libxrandr-dev \
	libxxf86vm-dev \
	libopenal-dev \
	libgl1-mesa-dev \
	libglu1-mesa-dev \
	zlib1g-dev \
	libcurl4-openssl-dev \
	mono-complete \
	zip \
	unzip \
	ffmpeg \
	rsync \
	git \
	&& rm -rf /var/lib/apt/lists/*

# Instructions from https://help.yoyogames.com/hc/en-us/articles/235186168-Setting-Up-For-Ubuntu-Linux-
# Steam runtimes
RUN mkdir /opt/steam-runtime/ && curl -s https://repo.steampowered.com/steamrt-images-scout/snapshots/latest-steam-client-general-availability/com.valvesoftware.SteamRuntime.Sdk-amd64,i386-scout-sysroot.tar.gz | tar -xzf - -C /opt/steam-runtime/

# Linuxdeploy
RUN curl -s https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage -o linuxdeploy-x86_64.AppImage && install -m 0755 linuxdeploy-x86_64.AppImage /usr/local/bin/linuxdeploy && rm linuxdeploy-x86_64.AppImage

# AppImage
RUN curl -s https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -o appimagetool-x86_64.AppImage && install -m 0755 appimagetool-x86_64.AppImage /usr/local/bin/appimagetool && rm appimagetool-x86_64.AppImage

# Set up SSH
RUN mkdir -p /run/sshd

# set up unprivilidged user
RUN useradd -ms /bin/bash builder && echo "builder:builder" | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]