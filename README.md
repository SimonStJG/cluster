My personal Raspberry PI Docker cluster
=======================================

# Setup Notes #

* Download raspbian lite image
* `sudo dd bs=4M if=2017-08-16-raspbian-stretch-lite.img of=/dev/sdf conv=fsync`
* `touch ssh` on newly created boot partition partition
* Boot device and find it on the network `nmap -sT 192.168.1.0/24`
* ssh-copy-id pi@192.168.1.XXX (pw is raspberry)
* ssh pi@192.168.1.XXX
  * Install vim: `sudo apt install vim`
  * vim /etc/ssh/sshd_config - PasswordAuthentication No
  * sudo service ssh restart
  * sudo apt-get update && sudo apt-get upgrade
  * curl -sSL https://get.docker.com | sh

  * sudo raspi-config set hostname
  * Do all the cert stuff
  * * https://docs.docker.com/engine/security/https/#create-a-ca-server-and-client-keys-with-openssl

  * You keep the same CA, for all nodes

  * vim /etc/systemd/system/multi-user.target.wants/docker.service and remove the -H flag
  * vim /etc/docker/daemon.json
  ```
  {
   "hosts": ["tcp://192.168.1.173:2376", "fd://"],
   "insecure-registries":["192.168.1.173:5000"],
   "tls": true,
   "tlsverify": true,
   "tlscacert": "/home/pi/certs/ca.pem",
   "tlscert": "/home/pi/certs/server-cert.pem",
   "tlskey": "/home/pi/certs/server-key.pem"
  }
  ```
  * sudo systemctl daemon-reload
  * sudo systemctl restart docker

* Actually deploy it `DOCKER_HOST=192.168.1.173:2376 docker-compose up -d`

OR
In swarm mode:
  DOCKER_HOST=192.168.1.173:2376 docker swarm init --advertise-addr 192.168.1.173
  Then join workers as described in output of above job

On host!
cd Registry && ./build.sh && docker build . && docker run -p "5000:5000" --detach 5b81eef8da3d

docker-compose build
docker-compose push
docker stack deploy --compose-file docker-compose.yml t1 --prune

# TODO #

* Grafana
* Have prometheus send email
* Better config and secrets injection
