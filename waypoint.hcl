project = "waypoint-python-k8s-demo"

app "flask-example" {
    build {
        use "docker" {}
        registry {
            use "aws-ecr" {
                region = "eu-west-1"
                repository = "ephemeral-waypoint"
                tag = gitrefpretty()
            }
        }
    }
    
    deploy {
        use "aws-ecs" {
            region = "eu-west-1"
            cluster = "dev-ecs"
            ec2_cluster = true
            memory = "256"
        }
    }
    
    url {
        auto_hostname = true
    }
}
