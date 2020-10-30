# waypoint-python-k8s-demo

Hashicorp Waypoint with Python Flask on Kubernetes Demo

## Docs

- https://www.waypointproject.io/docs
- https://www.waypointproject.io/plugins/kubernetes

## Demo

Install a Cluster:

```
$ curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s -
$ cat /etc/rancher/k3s/k3s.yaml | sed "s/127.0.0.1/$(curl -s -4 ifconfig.co)/g" > kubeconfig.yml
```

Copy the file to your laptop/workstation:

```
$ scp remote-k3s:~/kubeconfig.yml ~/.kube/remote-k3s_kubeconfig.yml
$ export KUBECONFIG=~/.kube/remote-k3s_kubeconfig.yml
```

Install waypointi client:

```
$ wget https://releases.hashicorp.com/waypoint/0.1.4/waypoint_0.1.4_darwin_amd64.zip
$ unzip waypoint_0.1.4_darwin_amd64.zip
$ sudo mv waypoint /usr/local/bin/
$ sudo chmod +x /usr/local/bin/waypoint
```

Test waypoint:

```
$ waypoint
Welcome to Waypoint
Docs: https://waypointproject.io
Version: v0.1.4
```

Test if you can talk to kubernetes:

```
$ kubectl get nodes -o wide
NAME         STATUS   ROLES    AGE   VERSION        INTERNAL-IP      EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION       CONTAINER-RUNTIME
ams-k3s-01   Ready    master   44m   v1.18.9+k3s1   51.x.x.x         <none>        Ubuntu 18.04.5 LTS   4.15.0-118-generic   containerd://1.3.3-k3s2
```

Install waypoint to Kubernetes:

```
$ waypoint install --platform kubernetes -accept-tos
 + Creating Kubernetes resources...
 │ service/waypoint created
 │ statefulset.apps/waypoint-server created
 + Kubernetes StatefulSet reporting ready
 + Waiting for Kubernetes service to become ready..
 + Configuring server...
Waypoint server successfully installed and configured!

The CLI has been configured to connect to the server automatically. This
connection information is saved in the CLI context named "install-1604084620".
Use the "waypoint context" CLI to manage CLI contexts.

The server has been configured to advertise the following address for
entrypoint communications. This must be a reachable address for all your
deployments. If this is incorrect, manually set it using the CLI command
"waypoint server config-set".

Advertise Address: 51.x.x.x:9701
Web UI Address: https://51.x.x.x:9702
```

Get the project code:

```
$ git clone https://github.com/ruanbekker/waypoint-python-k8s-demo
$ cd waypoint-python-k8s-demo
```

Initialize waypoint and build, ship and deploy:

```
$ waypoint init
$ waypoint up
...
 + Initializing Docker client...
 + Building image...
 │ Successfully built 9ad3810bfc78
 │ Successfully tagged waypoint.local/flask-example:latest
 + Injecting Waypoint Entrypoint...
 + Tagging Docker image: waypoint.local/flask-example:latest =>
ruanbekker/waypoint-flask-example:dca858f31c1e7bc6b31d8f9eb768e67289d15e8c_CHANGES_1604093131
 + Pushing Docker image...
 + Docker image pushed: ruanbekker/waypoint-flask-example:dca858f31c1e7bc6b31d8f9eb768e67289d15e8c_CHANGES_1604093131

» Deploying...
 + Kubernetes client connected to https://51.x.x.x:6443 with namespace default
 + Creating deployment...
 + Deployment successfully rolled out!

» Releasing...
 + Kubernetes client connected to https://51.x.x.x:6443 with namespace default
 + Creating service...
 + Service is ready!

The deploy was successful! A Waypoint deployment URL is shown below. This
can be used internally to check your deployment and is not meant for external
traffic. You can manage this hostname using "waypoint hostname."

   Release URL: http://10.43.34.213:80
Deployment URL: https://mutually-finer-leopard--v1.waypoint.run
```

Test out the endpoint:

```
$ curl https://mutually-finer-leopard--v1.waypoint.run
{"message":"hello, world!"}
```

Check the deployment:

```
$ kubectl get deployments
NAME                                       READY   UP-TO-DATE   AVAILABLE   AGE
flask-example-01enxpfc0h42t53hvxbxjygb5p   1/1     1            1           11m
```

View the image tag:

```
$ kubectl get deployment/flask-example-01enxpfc0h42t53hvxbxjygb5p -o=jsonpath='{$.spec.template.spec.containers[:1].image}'; echo
ruanbekker/waypoint-flask-example:dca858f31c1e7bc6b31d8f9eb768e67289d15e8c_CHANGES_1604093131
```
