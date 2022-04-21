# Spring boot 容器化运行实践

### 镜像信息
- docker.io/liangdi/spring-boot-launcher:latest 中 jdk 版本为 17 (FROM docker.io/library/openjdk:17-apline)
 - 其他版本 jdk 版本指定标签即可,如: liangdi/spring-boot-launcher:11, liangdi/spring-boot-launcher:8
 - jdk 8 和 jdk 11 为 openjdk:tag 版本 (FROM docker.io/library/openjdk:tag)

### 开发依赖
- buildah
- podman


### 思路
- 使用容器运行 spring-boot 项目
- jar 包不包含在 image 中,方便使用
- 使用环境便利对外暴露配置信息,方便扩展和集成

### 使用方法
- 默认的 jar 文件为 application.jar 可以通过 -e JAR=your.jar 修改
- 默认端口为 8080 , 可以通过 -e APP_PORT=port 修改
- 需要指定数据卷 -v /path/to/app_path:/deploy
  
#### 后台运行
```
# 端口根据实际情况修改, 这里使用 PORT 绑定了容器名称以及暴露的端口,这样可以批量启动容器实例,只需指定端口即可(可以自行随机生成),这可以正常服务发现.
PORT=9090
podman run -d --name sprin-boot-app-$PORT \
    -v ./:/deploy \
    -e APP_PORT=$PORT \
    -p $PORT:$PORT \
    docker.io/liangdi/spring-boot-launcher
```
#### 交互运行
podman run -it --rm \
    -v ./:/deploy \
    -e APP_PORT=$PORT \
    -p $PORT:$PORT \
    docker.io/liangdi/spring-boot-launcher:11 

### 打包编译

```
buildah build -t name:tag
```