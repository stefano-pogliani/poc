#!/bin/bash
#  Generate 2 CAs and 2 certs (one for each CA).
set -e

if [ -f "root-ca1.key.pem" ]; then
  echo "Found certs, skipping regen"
  echo "Sleeping forever while you play"
  while true; do
    sleep 2
  done
  exit 0
fi


# Create Root CA 1.
openssl genrsa -out "root-ca1.key.pem" 2048
openssl req -x509 -new -nodes -key "root-ca1.key.pem" \
  -days 9131 -out "root-ca1.crt.pem" \
  -subj "/C=GB/L=London/O=TestCaRollout/CN=mock.ca"

# Create Root CA 2.
openssl genrsa -out "root-ca2.key.pem" 2048
openssl req -x509 -new -nodes -key "root-ca2.key.pem" \
  -days 9131 -out "root-ca2.crt.pem" \
  -subj "/C=GB/L=London/O=TestCaRollout/CN=mock.ca"

# Combine CAs.
cat "root-ca1.crt.pem" "root-ca2.crt.pem" > "root-combined.crt.pem"


# Create client cert 1.
openssl genrsa -out "client1.key.pem" 2048
openssl req -new -key "client1.key.pem" -out "client1.csr.pem" \
  -subj "/C=GB/L=London/O=TestCaRollout/CN=client1.mock.ca"
openssl x509 -req -in "client1.csr.pem" -CA "root-ca1.crt.pem" \
  -CAkey "root-ca1.key.pem" -CAcreateserial \
  -out "client1.cert.pem" -days 1024
cat "client1.key.pem" "client1.cert.pem" > "client1.pem"

# Create client cert 2.
openssl genrsa -out "client2.key.pem" 2048
openssl req -new -key "client2.key.pem" -out "client2.csr.pem" \
  -subj "/C=GB/L=London/O=TestCaRollout/CN=client2.mock.ca"
openssl x509 -req -in "client2.csr.pem" -CA "root-ca2.crt.pem" \
  -CAkey "root-ca2.key.pem" -CAcreateserial \
  -out "client2.cert.pem" -days 1024
cat "client2.key.pem" "client2.cert.pem" > "client2.pem"


# Relax file perms because it is a test.
chmod 0644 ./*


# Wait forever until the user stops us.
echo
echo
echo "All done!"
echo "Sleeping forever while you play"
while true; do
  sleep 2
done
