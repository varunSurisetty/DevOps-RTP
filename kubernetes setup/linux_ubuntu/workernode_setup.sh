sudo hostnamectl set-hostname worker01
sudo systemctl stop apparmor && sudo systemctl disable apparmor
sudo systemctl restart containerd.service
sudo kubeadm join [master-node-ip]:6443 --token [token] --discovery-token-ca-cert-hash sha256:[hash]
