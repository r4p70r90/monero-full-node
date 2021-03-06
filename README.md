# monero-full-node

docker image to run a monero full network node with .conf file for configuration

# October 2018: Breaking Change
**warning**  
for improved security the new images will run the monero daemon under it's own user and not as root anymore!
If you simply upgrade without following the next steps you will run into this error:  
`WARN 	blockchain.db.lmdb	src/blockchain_db/lmdb/db_lmdb.cpp:75	Failed to open lmdb environment: Permission denied`

this can be fixed with the following steps  

* stop and remove the current container: `docker stop monerod && docker rm monerod`
* change the owner of the volume to monero user `docker run -v xmrchain:/home/monero -t --rm --name=monerod -u root --entrypoint=/bin/chown r4p70r90/monero-full-node -R monero:monero`
* start the container `docker run -tid --restart=always -v xmrchain:/home/monero -p 18080:18080 -p 18081:18081 --name=monerod r4p70r90/monero-full-node`

**Hint:** keep in mind that you have to adapt your volume bindings to your own configuration e.g. if you followed the older version of this readme you have to use: `-v /var/data/blockchain-xmr:/home/monero` instead of `-v xmrchain:/home/monero/`

# Usage

**first start:**  
you need to change the permission of the mounted volume to allow the monero user inside the container to write the blockain in the volume. To do this, you have to mount the volume where you want to store the blockchain to the container and chown that path to the monero user. e.g.

`docker run -v xmrchain:/home/monero -t --rm --name=monerod -u root --entrypoint=/bin/chown r4p70r90/monero-full-node -R monero:monero`

you have to do this only once before first start.

After this, you can start the container with e.g.

`docker run -tid --restart=always -v xmrchain:/home/monero -p 18080:18080 -p 18081:18081 --name=monerod r4p70r90/monero-full-node`

## How To Use
```
docker run -td \
-v /var/data/blockchain-xmr:/home/monero \
-p 18080:18080 \
-p 18081:18081 \
--name=monerod \
r4p70r90/monero-full-node
```

## Updates
Manual way:
```
docker stop monerod
docker rm monerod
docker pull r4p70r90/monero-full-node
```
Then launch using the "how to use" command above
    
Automatic way: [v2tec/watchtower](https://github.com/v2tec/watchtower)

# Donations

I am supporting this image in my spare time and would be very happy about some donations to keep this going. You can support me by sending some XMR to: `86fbBwa9XfZAHqMBA7TowSGb5oZqnBgUFJ8Zxh2WchjHWKw6Xx8zpwQiA4fFZVjYWAdE2jCes8WMujZEjYUwDomtVKTfvkb`
![Donation](https://docs.google.com/uc?export=download&id=13Z0oUgUKZsC6HCo69BHS5b9mvffT6QRG)
