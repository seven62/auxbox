# AUXbox
aux(ilary) box that provides multiple utility services for offline deployment

### toDO

[ ] - add links to tools / products in README  
[ ] - figure out how to `.sh` adding repos  
[ ] - https://www.tecmint.com/install-pxe-network-boot-server-in-centos-7/
[ ] - add configuration steps for each component  
[x] - PXE env will be covered under `DNSmasq` install process  

## Services

The following services are provided:

### configure NTP

This is a requirement for dnsmasq

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


## PXE

[x] - this will be covered under `DNSmasq` install process


## DHCP / DNS

* [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html)
