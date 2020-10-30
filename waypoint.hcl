project = "waypoint-python-k8s-demo"

app "flask-example" {
    build {
        use "docker" {}     
        registry {
            use "docker" {
                image = "ruanbekker/waypoint-flask-example"
                tag = gitrefpretty()
                local = false
            }
        }
    }

    deploy {
        use "kubernetes" {
            probe_path = "/health"
            service_port = 5000
            replicas = 1
        }
    }
    
    release {
        use "kubernetes" {}
    }
    
    url {
        auto_hostname = true
    }
}
