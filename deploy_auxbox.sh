#!/bin/bash

################################
######### Epel Release #########
################################
# The DISA STIG for CentOS 7.4.1708 enforces a GPG signature check for all repodata. While this is generally a good idea, it causes repos tha do not use GPG Armor to fail.
# One example of a repo that does not use GPG Armor is Epel; which is a dependency of CAPES (and tons of other projects, for that matter).
# To fix this, we are going to disable the GPG signature and local RPM GPG signature checking.
# I'm open to other options here.
# RHEL's official statement on this: https://access.redhat.com/solutions/2850911
sudo sed -i 's/repo_gpgcheck=1/repo_gpgcheck=0/' /etc/yum.conf
sudo sed -i 's/localpkg_gpgcheck=1/localpkg_gpgcheck=0/' /etc/yum.conf

################################
######## Configure NTP #########
################################

# Set your time to UTC, this is crucial. If you have already set your time in accordance with your local standards, you may comment this out.
# If you're not using UTC, I strongly recommend reading this: http://yellerapp.com/posts/2015-01-12-the-worst-server-setup-you-can-make.html
sudo timedatectl set-timezone UTC

# Set NTP. If you have already set your NTP in accordance with your local standards, you may comment this out.
sudo bash -c 'cat > /etc/chrony.conf <<EOF
# Use public servers from the pool.ntp.org project.
# Please consider joining the pool (http://www.pool.ntp.org/join.html).
server 0.centos.pool.ntp.org iburst
server 1.centos.pool.ntp.org iburst
server 2.centos.pool.ntp.org iburst
server 3.centos.pool.ntp.org iburst
# Ignore stratum in source selection.
stratumweight 0
# Record the rate at which the system clock gains/losses time.
driftfile /var/lib/chrony/drift
# Enable kernel RTC synchronization.
rtcsync
# In first three updates step the system clock instead of slew
# if the adjustment is larger than 10 seconds.
makestep 10 3
# Allow NTP client access from local network.
#allow 192.168/16
# Listen for commands only on localhost.
bindcmdaddress 127.0.0.1
bindcmdaddress ::1
# Serve time even if not synchronized to any NTP server.
#local stratum 10
keyfile /etc/chrony.keys
# Specify the key used as password for chronyc.
commandkey 1
# Generate command key if missing.
generatecommandkey
# Disable logging of client accesses.
noclientlog
# Send a message to syslog if a clock adjustment is larger than 0.5 seconds.
logchange 0.5
logdir /var/log/chrony
#log measurements statistics tracking
EOF'
sudo systemctl enable chronyd.service
sudo systemctl start chronyd.service


################################
########## Firewall ############
################################

# Port 80 - Nginx
# Port 3000 - RocketChat
# Port 4000 - Gitea
# Port 5000 - Etherpad
# Port 5601 - Kibana
# Port 7000 - Mumble
# Port 9000 - TheHive
# Port 9001 - Cortex (TheHive Analyzer Plugins)
sudo firewall-cmd --add-port=80/tcp --add-port=3000/tcp --add-port=4000/tcp --add-port=5000/tcp --add-port=5601/tcp --add-port=9000/tcp --add-port=9001/tcp --add-port=7000/tcp --add-port=7000/udp --permanent
sudo firewall-cmd --reload

################################
########## Services ############
################################

# Prepare the service environment
sudo systemctl daemon-reload

# Configure services for autostart
sudo systemctl enable tbd.service


# Start all the services
sudo systemctl start tbd.service


###############################
### Clear your Bash history ###
###############################

# We don't want anyone snooping around and seeing any passphrases you set
cat /dev/null > ~/.bash_history && history -c


################################
######### Success Page #########
################################
clear
echo "The tbd landing passphrase for the account \"tbd\" is: "$tbd
echo "Please see the "tbd" documentation for the post-installation steps."
echo "The tbd page has been successfully deployed. Browse to http://$HOSTNAME (or http://$IP if you don't have DNS set up) to begin using the services."
