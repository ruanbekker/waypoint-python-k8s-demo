# waypoint-python-k8s-demo

Hashicorp Waypoint with Python Flask on Kubernetes Demo

## Docs

- https://www.waypointproject.io/docs
- https://www.waypointproject.io/plugins/aws-ecs
- https://learn.hashicorp.com/tutorials/waypoint/aws-ecs?in=waypoint/deploy-aws

For ECS, the user needs the following policies assigned to it:

- AmazonECS_FullAccess 
- AmazonECSTaskExecutionRolePolicy 

## Demo

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

Install waypoint using the local method:

```
$ docker pull hashicorp/waypoint:latest
$ waypoint install --platform=docker -accept-tos
✓ Installing Waypoint server to docker
✓ Server container started!
✓ Configuring server...
Waypoint server successfully installed and configured!

The CLI has been configured to connect to the server automatically. This
connection information is saved in the CLI context named "install-1604317429".
Use the "waypoint context" CLI to manage CLI contexts.

The server has been configured to advertise the following address for
entrypoint communications. This must be a reachable address for all your
deployments. If this is incorrect, manually set it using the CLI command
"waypoint server config-set".

Advertise Address: waypoint-server:9701
Web UI Address: https://localhost:9702
```

Get the project code:

```
$ git clone https://github.com/ruanbekker/waypoint-python-k8s-demo
$ cd waypoint-python-k8s-demo
$ git checkout ecs
```

Initialize waypoint and build, ship and deploy:

```
$ export AWS_ACCESS_KEY_ID=xx
$ export AWS_SECRET_ACCESS_KEY=xx

$ waypoint init
$ waypoint up

» Building...
✓ Initializing Docker client...
✓ Building image...
✓ Initializing Docker client...
✓ Building image...
✓ Injecting Waypoint Entrypoint...
Tagging Docker image: waypoint.local/flask-example:latest =>
xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/ephemeral-waypoint:b964223df10d984f16f32cdf1aa05b783abb0154_CHANGES_1604325493
Docker image pushed: xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/ephemeral-waypoint:b964223df10d984f16f32cdf1aa05b783abb0154_CHANGES_1604325493

» Deploying...
✓ Found existing ECS cluster: eph-dev-ecs
✓ Created IAM role: ecr-flask-example
✓ Created ALB target group
✓ Created new ALB Listener
✓ Configured security group: flask-example-inbound-internal
✓ Created ECS Service (flask-example-1W5BPWMQZK8HR29W4G, cluster-name: eph-dev-ecs)

» Releasing...

The deploy was successful! A Waypoint deployment URL is shown below. This
can be used internally to check your deployment and is not meant for external
traffic. You can manage this hostname using "waypoint hostname."

   Release URL: http://waypoint-ecs-flask-example-xxxxxx.eu-west-1.elb.amazonaws.com
Deployment URL: https://grossly-sacred-buzzard--v17.waypoint.run
```

Test out the endpoint:

```
$ curl http://waypoint-ecs-flask-example-xxxxxx.eu-west-1.elb.amazonaws.com
{"message":"hello, world!"}
```

Clean up:

```
$ waypoint destroy

» Destroying releases...
» Destroying deployments...

Destroy successful!
```
