# 指定基础镜像
FROM golang:1.17.8-alpine

# 维护者信息
MAINTAINER jueying hhbvictory@163.com

# 复制脚本文件到容器目录中
COPY entrypoint.sh /sbin/entrypoint.sh

# 运行指令
RUN chmod 755 /sbin/entrypoint.sh \
  && apk add --no-cache git make openssl \
  && tar -zxvf /tmp/ngrok.tar.gz -C /usr/local \
  && rm -rf /tmp/ngrok.tar.gz

# 允许指定的端口
EXPOSE 80/tcp 443/tcp 8081/tcp 8082/tcp

# 指定ngrok运行入口
ENTRYPOINT ["/sbin/entrypoint.sh"]
