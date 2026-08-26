---
title: ELK安装流程
date: 2025-04-11 17:16:46
categories: 后端
---

# 使用 Docker 安装 ELK Stack（ElasticSearch、Logstash、Kibana）

> 建议在 Docker 上安装，资源占用少。以下安装版本统一为 **8.12.2**，建议保持一致避免冲突。

## 目录

[1、安装 ElasticSearch](#1、安装-ElasticSearch)
[2、安装 Logstash](#2、安装-Logstash)  
[3、安装 Kibana](#3、安装-Kibana)  
[推荐](#推荐)



---

## 1、安装 ElasticSearch

- 拉取镜像：

```bash
docker pull elasticsearch:8.12.2
```

- 启动容器：

```bash
docker run --name some-elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -d elasticsearch:8.12.2
```

- 进入容器内部：

```bash
sudo docker exec -u 0 -it some-elasticsearch bash
```

- 重启容器：

```bash
docker restart some-elasticsearch
```

---

## 2、安装 Logstash

- 拉取镜像：

```bash
docker pull docker.elastic.co/logstash/logstash:8.12.2
```

- 启动容器：

```bash
sudo docker run -it -p 5044:5044 -p 9600:9600 --name logstash -v /usr/share/logstash/piplines:/usr/share/logstash/config --privileged=true docker.elastic.co/logstash/logstash:8.12.2 /bin/bash
```

- 使用 `scp` 命令将本机下载好的 jar 包（MySQL Connector）上传至虚拟机：

```bash
scp "/Users/Downloads/logstash-8.12.2/mysql-connector-j-8.4.0.jar" 用户名@虚拟机IP:/home
```

- 再将 jar 包从虚拟机移动到 logstash 容器中：

```bash
docker cp ./mysql-connector-j-8.4.0.jar logstash:/usr/share/logstash
```

- 进入容器内部：

```bash
docker exec -u 0 -it logstash bash
```

---

## 3、安装 Kibana

- 拉取镜像：

```bash
docker pull kibana:8.12.2
```

- 启动容器：

```bash
docker run --name some-kibana -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -d elasticsearch:8.12.2
```

- 进入容器：

```bash
docker exec -u 0 -it some-kibana bash
```

---

## 附：安装 Docker、Portainer 及相关命令

```bash
sudo apt update
sudo apt install docker.io docker-compose
docker -v
sudo systemctl start docker

sudo docker search portainer
docker pull portainer/portainer
sudo docker pull portainer/portainer
sudo docker run -d --name portainerUI -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer

sudo docker start portainerUI
sudo passwd root
```

---

## 推荐

- [娱乐一下](https://edunextgen1.com)

