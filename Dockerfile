FROM ubuntu:18.04

# SDKs needed, from https://help.yoyogames.com/hc/en-us/articles/235186168-Setting-Up-For-Ubuntu
RUN apt-get update && apt-get install --no-install-recommends --yes \
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
      && rm -rf /var/lib/apt/lists/*

# Set up SSH
RUN mkdir -p /run/sshd

# set up unprivilidged user
RUN useradd -ms /bin/bash builder && echo "builder:builder" | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]