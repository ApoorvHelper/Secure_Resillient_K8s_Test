#!bin/bash
# ---------- On CONTROL-PLANE NODE ----------
# Initialize cluster (Calico expects 192.168.0.0/16 by default)
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

# Configure kubectl for the current user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Calico CNI
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.3/manifests/calico.yaml

# (Optional) Taint removal if running workloads on control plane
# kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# Capture the join command for workers
kubeadm token create --print-join-command

