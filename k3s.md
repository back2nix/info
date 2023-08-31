####

- https://www.youtube.com/watch?v=UoOcLXfa8EU
- https://docs.technotim.live/posts/k3s-ha-install/
- https://docs.technotim.live/posts/k3s-etcd-ansible/

```
#INSTALL_K3S_CHANNEL=latest
curl -sfL https://get.k3s.io |  sh -s - server
curl -sfL https://get.k3s.io | sh -s - server  --tls-san 10.177.11.120
curl -sfL https://get.k3s.io | sh -s - server --token=K10e186d16b616f94d68e7cfba85dcea08245d9dbf1f137b8e93a7f32c308dd67d1::server:5aaf14014a7cc4bbb1e2de26001a1c17 --tls-san 10.177.11.52

sudo k3s kubectl get nodes

sudo cat /var/lib/rancher/k3s/server/node-token

sudo cat /etc/rancher/k3s/k3s.yaml


curl -sfL https://get.k3s.io | K3S_URL=https://10.177.11.52:6443 K3S_TOKEN=K10e186d16b616f94d68e7cfba85dcea08245d9dbf1f137b8e93a7f32c308dd67d1::server:5aaf14014a7cc4bbb1e2de26001a1c17 sh -

sudo kubectl get pods

# export KUBECONFIG=$HOME/.kube/config

sudo kubectl get nodes --kubeconfig ~/.kube/config

sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.0/aio/deploy/recommended.yaml

sudo systemctl restart k3s

sudo k3s kubectl proxy --kubeconfig ~/.kube/config

sudo k3s kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

sudo kubectl apply -f testdeploy.yml --kubeconfig ~/.kube/config

kubectl delete -n default deployment mysite

sudo kubectl get pods -o wide
sudo kubectl scale deploy mysite --replicas=0
sudo kubectl scale -n default statefulset mongo --replicas=0

sudo kubectl get statefulset
sudo kubectl describe statefulset

sudo kubectl expose statefulset mongo --type=LoadBalancer --name=mongo-0

sudo kubectl delete -n default service example-service
sudo kubectl delete -n default statefulset mongo-0
sudo kubectl delete --all pods --namespace=default

kubectl delete pvc --all

sudo kubectl get pod mongo-0  --template='{{(index (index .spec.containers 0).ports 0).containerPort}}{{"\n"}}'

sudo kubectl port-forward mongo-0 28015:27017

kuberctl create secret generic name-secret --from-file ./secret
kuberctl describe secret name-secret

/usr/local/bin/k3s-uninstall.sh
/usr/local/bin/k3s-agent-uninstall.sh
```

### links

- https://github.com/justmeandopensource/kubernetes
- https://k3d.io/v5.4.3/

### k9s

```
wget https://github.com/derailed/k9s/releases/download/v0.25.21/k9s_Linux_x86_64.tar.gz
tar -xvf k9s_Linux_x86_64.tar.gz
sudo chmod +x k9s
sudo mv k9s /usr/bin/
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown ubuntu:ubuntu ~/.kube/config
```

#### k3d

- https://k3d.io/v5.4.3/#installation

```
https://k3d.io/v5.4.1/usage/exposing_services/
```

### mongo

```
https://blog.knoldus.com/how-to-deploy-mongodb-cluster-on-kubernetes/
```
- https://www.youtube.com/watch?v=k9-Pw0v0Cjw

#### mongo port forwarding

- https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/

```
kubectl apply -f https://k8s.io/examples/application/mongodb/mongo-deployment.yaml
kubectl get pods
kubectl apply -f https://k8s.io/examples/application/mongodb/mongo-service.yaml

# Change mongo-75f59d57f4-4nd6q to the name of the Pod
kubectl get pod mongo-75f59d57f4-4nd6q --template='{{(index (index .spec.containers 0).ports 0).containerPort}}{{"\n"}}'
kubectl port-forward mongo-75f59d57f4-4nd6q 28015:27017
```

#### kubectl

```
export KUBECONFIG=$HOME/.kube/config
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

#### Последовательность

```
# Apply k8s config
kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
```

####  Создание сервиса

- https://www.youtube.com/watch?v=QcC-5fRhsM8

#### Artifact hub io

- https://artifacthub.io/

- https://artifacthub.io/

#### Docker regestry kuber

- https://www.youtube.com/watch?v=r15S2tBevoE

#### Traefik

- https://www.youtube.com/watch?v=scrtJ1U4wJU


#### ConfigMap

- https://www.youtube.com/watch?v=elCSzQUOyfU

```
data:
  config.json: |
    {
      "welcome": {{ pluck .Values.global.env .Values.welcome | first | quote }},
      "name": {{ pluck .Values.global.env .Values.name | first | quote }}
    }
  database.yml: |
    host: 127.0.0.1
    db: app
    user: app
    password: app
```

- Create a Kubernetes Configmap with custom nginx.conf using kubectl:

```
kubectl create configmap nginx-config --from-file=nginx.conf
```

#### Docker login private registry

- https://rpi4cluster.com/k3s/k3s-docker-tls/
- https://rpi4cluster.com/k3s/k3s-storage-setting/#install-longhorn

```
kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=config.json \
    --type=kubernetes.io/dockerconfigjson

kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
```

#### longhorn

```
kubectl delete ns longhorn-system
helm uninstall longhorn -n longhorn-system --no-hooks
iptables --policy FORWARD ACCEPT

kubectl logs -f longhorn-csi-plugin-vzbwf -n longhorn-system
```
```
wget https://raw.githubusercontent.com/longhorn/longhorn/master/scripts/environment_check.sh
bash environment_check.sh
apt install open-iscsi jq -y
apt install nfs-common
service open-iscsi start
systemctl start iscsid
systemctl enable iscsid
```

#### ufw 


```
vim /etc/default/ufw
DEFAULT_FORWARD_POLICY="ACCEPT"
```

```
ufw default allow FORWARD
ufw default allow routed
```

#### certs

```
rsync -avP --rsync-path="sudo rsync" registry.crt  registry.key root@beget.gh.node0:/usr/local/share/ca-certificates/
update-ca-certificates

systemctl restart k3s-agent
systemctl restart k3s
```

```
kubectl edit serviceaccount default -n default
```
