# cloud9_centos7
Install cloud9 on CentOS7 Docker image

ref:https://github.com/c9/core

# Usage
```
docker build . -t mycloud9:3

docker run -d \
           --name cloud9_default \
           -p 18181:8181 \
           mycloud9:3

http://[HOST]:18181/ide.html

mkdir -p ~/cloud9/workspc
docker run -d \
           --name cloud9 \
           -p 18080:8080 \
           -v ~/cloud9/workspc:/cloud9/workspc \
           mycloud9:3 \
             -w /cloud9/workspc \
             --port 8080 \
             --listen 0.0.0.0 \
             --auth username:password

docker run -d \
           -u 1000:1000 \
           --name cloud9 \
           -p 18080:8080 \
           -v ~/cloud9/workspc:/cloud9/workspc \
           mycloud9:3 \
             -w /cloud9/workspc \
             --port 8080 \
             --listen 0.0.0.0 \
             --auth :
```

http://[HOST]:18080/ide.html

1000:1000相当のユーザを作成し、それでインストール実行することで
ホスト側の同一権限のユーザが管理している好きなディレクトリをworkdirとして直接触れるように
したパターン。

```
docker build -t mycloud9:3 -f Dockerfile_mycentosdev .

docker run -d \
           --name cloud9 \
           -p 28181:8181 \
           -v ~/:/cloud9/workspc \
           mycloud9:3
```
