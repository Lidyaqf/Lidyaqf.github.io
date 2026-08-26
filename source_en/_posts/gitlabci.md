---
title: GitLab CI/CD
date: 2025-04-10 11:41:51
tags: 前端
categories: 前端
---
# 前端项目 GitLab CI/CD 持续集成部署指南（Mac 环境）

## 概要

在日常开发过程中，我们经常需要将打包后的 `dist` 包手动发送给后端部署，效率低且容易出错。CI（Continuous Integration，持续集成）可以自动化这一过程，本文将介绍如何通过 GitLab CI 实现持续集成部署。

---

## 一、安装 GitLab Runner

请参考官方文档：[GitLab Runner 安装指南](https://docs.gitlab.com/runner/install/)

---

## 二、本地注册 Runner

1. 打开你的 GitLab 项目页面，进入 **Settings → CI/CD**，展开 **Runners** 部分。
2. 记住显示的 **URL** 和 **token**，用于后续注册。

### 执行注册命令

```bash
gitlab-runner register
```

按照提示依次输入以下信息：

- GitLab CI Coordinator URL: `https://gitlab.com`
- GitLab CI Token: `xxx`（从项目中复制）
- Tags: `my-tag,another-tag`（自定义）
- Description: `my-runner`（自定义）
- Executor: `shell`（Mac 上建议选择 shell）

注册完成后，回到 GitLab CI/CD 设置页面，可看到 Runner 状态为绿色，说明已成功运行。如果不是绿色，请执行以下命令启动 Runner 服务：

```bash
gitlab-runner run
```

---

## 三、编写 `.gitlab-ci.yml` 文件并提交

将以下内容保存为 `.gitlab-ci.yml`，并 push 到 GitLab：

```yaml
stages:
  - deploy

deploy_to_test:
  stage: deploy
  script:
    - yarn
    - rm -rf dist/
    - yarn build
    - ls -l -t ./dist/
    - rsync -avz ./dist/ root@xxx.xx.xx.xxx:/dist
```

- 这段 CI 脚本会自动打包项目，并使用 `rsync` 将 `dist` 目录部署到远程服务器。

---

## 四、通过 Docker 实现 CI（可选）

如果需要通过 Docker 实现更完整的 CI/CD 流程，继续以下步骤：

### 1. 安装 Docker（Mac）

```bash
brew install --cask docker
```

### 2. 拉取 GitLab 镜像

```bash
docker pull drud/gitlab-ce:v0.29.1
```

### 3. 创建 GitLab 容器

```bash
docker run -d -p 8443:443 -p 8090:80 -p 8022:22 --restart always --name gitlab drud/gitlab-ce:v0.29.1
```

说明：

- `-p 8443:443`：映射 HTTPS 端口
- `-p 8090:80`：映射 HTTP 端口
- `-p 8022:22`：映射 SSH 端口
- `--restart always`：容器崩溃或主机重启时自动恢复
- `--name gitlab`：容器命名为 `gitlab`

访问地址：

```text
http://localhost:8090/
```

---

## 五、Docker 模式下的 `.gitlab-ci.yml` 示例

```yaml
variables:
  TEST_NAME: "tips"
  OUT_PORT: "8081"
  IN_PORT: "8081"

stages:
  - deploy

deploy_to_test:
  stage: deploy
  before_script:
    - if [ $(docker ps -aq --filter name=$CI_PROJECT_NAME) ]; then docker rm -f $CI_PROJECT_NAME; fi
  script:
    - docker build -f Dockerfile -t $TEST_NAME:latest .
    - docker run -d -p $OUT_PORT:$IN_PORT --name $TEST_NAME $TEST_NAME:latest
```

部署成功后，在 GitLab 的 CI/CD Pipelines 页面可看到构建过程，在 **Containers** 页面会生成新容器，点击对应端口即可访问部署后的页面。

---

## 推荐

- [娱乐一下](https://edunextgen1.com)
<!-- - [前端持续集成部署 CI/CD - CSDN](https://blog.csdn.net) -->
