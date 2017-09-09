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
  * vim /etc/systemd/system/multi-user.target.wants/docker.service and remove the -H flag
  * vim /etc/docker/daemon.json
  ```
  {
   "hosts": ["tcp://0.0.0.0:2376", "fd://"]
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
DOCKER_HOST=192.168.1.173:2376  docker pull cblomart/rpi-registry
DOCKER_HOST=192.168.1.173:2376 docker service create --name registry --publish 5000:5000 cblomart/rpi-registry


# TODO #

* Compress the nodeexporter into something reasonable - don't use make?

* Finish the tiny server, and put the radio on it.
* Expose to the world with DNS
* Add grafana for prometheus
* Have prometheus send email

* Docker swarm oh yeah
* Try and get prometheus to run on something smaller
* * https://github.com/prometheus/busybox
* Better security (don't expose 2376 unsecured)
* Dailywhiskers doesn't shut down properly
* Better config and secrets injection

