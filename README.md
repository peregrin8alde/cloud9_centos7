# cloud9_centos7
Install cloud9 on CentOS7 Docker image

ref:https://github.com/c9/core

# Usage
```
docker build . -t mycloud9:3

mkdir ~/cloud9
docker run -d \
           --name cloud9 \
           -p 28080:8080 \
           -v ~/cloud9/workspc:/cloud9/workspc \
           mycloud9:3 \
             -w /cloud9/workspc \
             --port 8080 \
             --listen 0.0.0.0 \
             --auth username:password
```
