
####################################################
########      HOSTNAME AND IP-ADD        ###########
####################################################

sudo hostnamectl set-hostname master-node

# Edit the hosts file on each node by adding the IP addresses and hostnames of the servers that will be part of the cluster.
sudo nano /etc/hosts
# add (ip-address hostname)


####################################################
########      KUBELET FILE SETUP         ###########
####################################################

#edit kubelet file
sudo nano /etc/default/kubelet
KUBELET_EXTRA_ARGS="--cgroup-driver=cgroupfs"

sudo systemctl daemon-reload && sudo systemctl restart kubelet



###################################################
########      DOCKER SETUP              ###########
###################################################

#edit docker file
sudo nano /etc/docker/daemon.json
{
       "exec-opts": ["native.cgroupdriver=systemd"],
       "log-driver": "json-file",
       "log-opts": {
       "max-size": "100m"
    },
        "storage-driver": "overlay2"
        }

#restart
sudo systemctl daemon-reload && sudo systemctl restart docker


####################################################
########      KUBEADM  CONF FILE SETUP   ###########
####################################################

#edit kubeadm conf file
sudo nano /lib/systemd/system/kubelet.service.d/10-kubeadm.conf
Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"

#restart
sudo systemctl daemon-reload && sudo systemctl restart kubelet



####################################################
########      KUBEADM INITIALISE         ###########
####################################################

#initialise kubeadm in masteer node
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --control-plane-endpoint=master-node --upload-certs 
#--ignore-preflight-errors=all

#if failed for once, 
#sudo kubeadm reset
#and follow all commands again


####################################################
########      HOME KUBE DIR SETUP        ###########
####################################################

#11. Create a directory for the Kubernetes cluster:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


#Step 4: Deploy Pod Network to Cluster
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.49.0/deploy/static/provider/baremetal/deploy.yaml


kubectl taint nodes --all node-role.kubernetes.io/control-plane-
kubectl get nodes
