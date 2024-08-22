sudo hostnamectl set-hostname master-node

# Edit the hosts file on each node by adding the IP addresses and hostnames of the servers that will be part of the cluster.
sudo nano /etc/hosts
# add (ip-address hostname)

#edit kubelet file
sudo nano /etc/default/kubelet
# add KUBELET_EXTRA_ARGS="--cgroup-driver=cgroupfs"

sudo systemctl daemon-reload && sudo systemctl restart kubelet

#edit docker file
sudo nano /etc/docker/daemon.json
# {
#       "exec-opts": ["native.cgroupdriver=systemd"],
#       "log-driver": "json-file",
#       "log-opts": {
#       "max-size": "100m"
#    },
#        "storage-driver": "overlay2"
#        }

#restart
sudo systemctl daemon-reload && sudo systemctl restart docker

#edit kubeadm conf file
sudo nano /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
# add Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"

#restart
sudo systemctl daemon-reload && sudo systemctl restart kubelet

#initialise kubeadm in masteer node
sudo kubeadm init --control-plane-endpoint=master-node --upload-certs --ignore-preflight-errors=all


#11. Create a directory for the Kubernetes cluster:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


#Step 4: Deploy Pod Network to Cluster
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
kubectl get nodes
