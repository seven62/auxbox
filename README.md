# AUXbox
aux(ilary) box that provides multiple utility services for offline deployment

### toDO

[ ] - add links to tools / products in README
[ ] - figure out how to `.sh` adding repos
[ ] - research PXE tool options
[ ] - add configuration steps for each component

## Services

The following services are provided:

### local repo store

* base
* update
* extras
* epel
* rock
* elastic

### file share

* reverse proxy - [lighttpd](https://www.lighttpd.net/)
* NFS share


##### ISO

* Centos7
* RHEL 7
* ESXi 6.5 u1 +
* ROCK 2.1a
* macOS (current)

##### misc

[ ] - brainstorm more served content


## PXE

[ ] - need options

## DHCP / DNS

* [dnsmasq]


## Git Server

* [gitea](gitea.io)



## Misc

* ansible
* vim
* tmux
* tree
* brad's dotfiles




## Install Process - v1

```
### install lighttpd webserver ###
sudo yum install -y lighttpd.x86_64

### INSTALL NFS ###
sudo yum install -y nfs-utils.x86_64

### INSTALL reposync ###
sudo yum install -y yum-utils-1.1.31-42

### install epel repo ###
sudo yum install epel-release

### install rock repo ###
https://packagecloud.io/rocknsm/2/el/7/$basearch

### INSTALL elastic repo ###

sudo vim /etc/yum.repos.d/elastic.repo

  [elasticsearch-6.x]
  name=Elasticsearch repository for 6.x packages
  baseurl=https://artifacts.elastic.co/packages/6.x/yum
  gpgcheck=1
  gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
  enabled=1
  autorefresh=1
  type=rpm-md


### INSTALL DHCP / DNS ###
sudo yum install -y dnsmasq.x86_64 # : A lightweight DHCP/caching DNS server
sudo yum install -y dnsmasq-utils.x86_64 # : Utilities for manipulating DHCP server leases


### INSTALL GITEA ###
# Install dependencies
sudo yum install -y git
sudo yum install -y mariadb-server
sudo systemctl start mariadb.service

###### INSTALL MISC ######

# install misc
sudo yum install -y \
vim \
git \
tmux \
ansible \
htop \

```
