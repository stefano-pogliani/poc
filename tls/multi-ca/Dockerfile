FROM fedora:26

RUN mkdir -p /opt/certs && dnf install -y openssl
COPY make-certs.sh /make-certs.sh

WORKDIR /opt/certs
CMD ["/make-certs.sh"]
