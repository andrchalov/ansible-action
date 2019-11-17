FROM alpine:latest

RUN echo "=== INSTALLING SYS DEPS" && \
  apk update && \
  apk add --no-cache \
    ca-certificates \
    openssh-client \
    python3  && \
  apk --update add --virtual \
    builddeps \
    python3-dev \
    libffi-dev \
    openssl-dev \
    build-base && \
  \
  echo "=== INSTALLING PIP DEPS" && \
  pip3 install --upgrade \
    pip && \
  pip3 install \
    ansible && \
  \
  echo "=== Cleanup ===" \
  apk upgrade && \
  apk del builddeps && \
  rm -rf /var/cache/apk/*

RUN mkdir -p /etc/ansible \
  && echo 'localhost' > /etc/ansible/hosts \
  && echo -e """\
\n\
Host *\n\
  StrictHostKeyChecking no\n\
  UserKnownHostsFile=/dev/null\n\
""" >> /etc/ssh/ssh_config

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
