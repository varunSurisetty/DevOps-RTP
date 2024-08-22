sudo hostnamectl set-hostname worker01

# Edit the hosts file on each node by adding the IP addresses and hostnames of the servers that will be part of the cluster.
sudo nano /etc/hosts
# add (ip-address hostname)

sudo systemctl stop apparmor && sudo systemctl disable apparmor
sudo systemctl restart containerd.service
sudo kubeadm join [master-node-ip]:6443 --token [token] --discovery-token-ca-cert-hash sha256:[hash]
