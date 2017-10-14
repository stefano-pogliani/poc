Rolling CAs
===========
Test out sharing CAs in one PEM file.
Change the root CA and client certs in the docker compose file.


MongoDB
-------
```bash
# Generate certs, start server and client.
docker-compose up

# Enter client and connect to server.
docker-compose exec mongo-client
mongo --ssl --sslCAFile /opt/certs/root-ca1.crt.pem --sslPEMKeyFile /opt/certs/client2.pem --host client1.mock.ca
```
