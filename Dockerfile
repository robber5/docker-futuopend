# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set the working directory
WORKDIR /root

# 安装必要的系统依赖
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    tar \
    telnet \
    tzdata \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 设置时区
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD opendctl.sh /usr/local/bin/opendctl.sh
RUN chmod +x /usr/local/bin/opendctl.sh

# 下载和安装 FutuOpenD
ENV FUTU_OPEND_VERSION=9.3.5308

# 使用最新的下载地址
RUN wget -O FutuOpenD.tar.gz "https://softwaredownload.futunn.com/Futu_OpenD_${FUTU_OPEND_VERSION}_Ubuntu16.04.tar.gz" \
    && tar -xzf FutuOpenD.tar.gz \
    && rm FutuOpenD.tar.gz \
    && mv Futu_OpenD_${FUTU_OPEND_VERSION}_Ubuntu16.04/Futu_OpenD_${FUTU_OPEND_VERSION}_Ubuntu16.04 Futu_OpenD \
    && rm -rf Futu_OpenD_${FUTU_OPEND_VERSION}_Ubuntu16.04 \
    && chmod +x Futu_OpenD/FutuOpenD

USER root

EXPOSE 11111

# Command to start FutuOpenD with environment variables
CMD ["/bin/sh", "-c", "/root/Futu_OpenD/FutuOpenD --login_account=${LOGIN_ACCOUNT} --login_pwd=${LOGIN_PWD} --api_ip=0.0.0.0 --telnet_ip=127.0.0.1 --telnet_port=22222"]