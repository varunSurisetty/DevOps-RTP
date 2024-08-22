# install kubernetes in ubuntu 22.04 linux machine

####################################################
########         SETUP DOCKER     ##################
####################################################
# Kubernetes requires a CRI-compliant container engine - Docker for our case

sudo apt update
sudo apt install docker.io -y
sudo chmod 666 /var/run/docker.sock

#docker to launch on boot
sudo systemctl enable docker

sudo systemctl status docker

# if docker not running, run below command
#sudo systemctl start docker

####################################################
######## Add Kubernetes Signing Key ################
####################################################
sudo apt install apt-transport-https ca-certificates curl gpg -y
sudo mkdir -p -m 755 /etc/apt/keyrings

#adding the Kubernetes repository to the APT sources list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

#Kubernetes is not included in the default Ubuntu repositories. To add the Kubernetes repository to your list, enter this command on each node:
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update

sudo apt install kubeadm kubelet kubectl -y

sudo apt-mark hold kubeadm kubelet kubectl


####################################################
########      DEPLOY KUBERNETES          ###########
####################################################

#Disable all swap spaces
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

#Load the required containerd modules
sudo nano /etc/modules-load.d/containerd.conf
#add 
#overlay
#br_netfilter
#in nano editor
sudo modprobe overlay
sudo modprobe br_netfilter

# edit kubernetes.conf file to configure Kubernetes networking
sudo nano /etc/sysctl.d/kubernetes.conf
#net.bridge.bridge-nf-call-ip6tables = 1
#net.bridge.bridge-nf-call-iptables = 1
#net.ipv4.ip_forward = 1

#reload
sudo sysctl --system
