FROM centos:7
MAINTAINER Okada Hayato

###
# CentOS7ベース開発用環境
# - 基本的なパッケージ群のインストール
#     - EPEL
#     - base / "Development Tools"グループ
#     - open-ssh / sudo / openjdk1.8
# - 日本語周りの設定
# - パスワードなしでsudo可能なユーザの作成
# - sshの公開鍵認証用設定
###
ENV LANG=ja_JP.UTF-8 \
    DEFAULT_USER=docker \
    DEFAULT_PWD=docker

RUN yum update -y \
    && yum install -y epel-release \
    && yum groupinstall -y base "Development Tools" \
    && yum install -y openssh-server openssh-client \
    && yum install -y sudo java-1.8.0-openjdk java-1.8.0-openjdk-devel \
    && localedef -i ja_JP -f UTF-8 ja_JP.UTF-8 \
    && localedef -i ja_JP -f EUC-JP ja_JP.eucJP \
    && localedef -i ja_JP -f SHIFT_JIS ja_JP.sjis \
    && echo LANG="ja_JP.UTF-8" > /etc/locale.conf \
    && unlink /etc/localtime \
    && ln -s /usr/share/zoneinfo/Japan /etc/localtime \
    && useradd -m ${DEFAULT_USER} \
    && echo ${DEFAULT_USER}:${DEFAULT_PWD} | chpasswd \
    && echo "${DEFAULT_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && sed -ri 's/!visiblepw/visiblepw/' /etc/sudoers \
    && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key \
    && sed -ri 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && sudo -u ${DEFAULT_USER} ssh-keygen -t rsa -N "" -f /home/${DEFAULT_USER}/.ssh/id_rsa \
    && sudo -u ${DEFAULT_USER} chmod 700 /home/${DEFAULT_USER}/.ssh \
    && sudo -u ${DEFAULT_USER} touch /home/${DEFAULT_USER}/.ssh/authorized_keys \
    && sudo -u ${DEFAULT_USER} chmod 600 /home/${DEFAULT_USER}/.ssh/authorized_keys \
    && echo "Host 10.0.0.*" | sudo -u ${DEFAULT_USER} tee -a /home/${DEFAULT_USER}/.ssh/config \
    && echo "   StrictHostKeyChecking no" | sudo -u ${DEFAULT_USER} tee -a /home/${DEFAULT_USER}/.ssh/config \
    && echo "   UserKnownHostsFile=/dev/null" | sudo -u ${DEFAULT_USER} tee -a /home/${DEFAULT_USER}/.ssh/config \
    && chown ${DEFAULT_USER}:${DEFAULT_USER} /home/${DEFAULT_USER}/.ssh/config \
    && sudo -u ${DEFAULT_USER} chmod 600 /home/${DEFAULT_USER}/.ssh/config

USER ${DEFAULT_USER}

EXPOSE 22

CMD ["sudo", "/usr/sbin/sshd", "-D"]

