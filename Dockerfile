FROM chenjr0719/ubuntu-unity-novnc
MAINTAINER BiStormLLC <info@bistorm.org>

# Install Firefox
RUN apt-get update && apt-get install -y \
    firefox

# Development tools
COPY code_1.11.2-1492070517_amd64.deb /
COPY docker-ce_17.04.0-ce-0-ubuntu-xenial_amd64.deb /
# Install .Net Core, then VS Code, Docker, then other dependencies for development
RUN apt-get update \
    && apt-get install -y apt-transport-https \
        ca-certificates \
        iptables \
        curl \
        software-properties-common \
    && sh -c 'echo "deb [arch=amd64] http://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list' \
    && sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 \
    && dpkg -i /code_1.11.2-1492070517_amd64.deb \
    && dpkg -i /docker-ce_17.04.0-ce-0-ubuntu-xenial_amd64.deb \
    && apt-get install -f \
    && apt-get update && apt-get install -y dotnet-dev-1.0.1 \
        libxss1 \
        libgconf-2-4 \ 
        terminator \ 
        build-essential \
        xrdp \
        vim \
    && curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
    && sudo apt-get install -y nodejs \
    && npm install -g webpack \
    && npm install -g yo \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 6080 5901 4040 3389 5000
CMD ["/bin/bash", "/home/ubuntu/startup.sh"]
