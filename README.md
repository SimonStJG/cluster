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
   "hosts": ["tcp://192.168.1.173:2376", "fd://"]
  }
  ```
  * sudo systemctl daemon-reload
  * sudo systemctl restart docker
* Actually deploy it `DOCKER_HOST=192.168.1.173:2376 docker-compose up -d`

# TODO #

* Better security (don't expose 2376 unsecured)
* Dailywhiskers doesn't shut down properly
* Add some prometheus alerts
* Have prometheus send email
* Monitor underlying host with node_exporter
