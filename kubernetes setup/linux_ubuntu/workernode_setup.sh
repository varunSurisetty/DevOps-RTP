sudo hostnamectl set-hostname worker01

# Edit the hosts file on each node by adding the IP addresses and hostnames of the servers that will be part of the cluster.
sudo nano /etc/hosts
# add (ip-address hostname)


#run this command in master node to get join command and copy the command to clipboard
kubeadm token create --print-join-command

sudo systemctl stop apparmor && sudo systemctl disable apparmor
sudo systemctl restart containerd.service

