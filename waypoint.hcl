project = "waypoint-python-k8s-demo"

app "python-example" {
    labels = {
        "service" = "python-example",
        "env" = "dev"
    }

    build {
        use "docker" {}    
    }
    
    registry {
        use "docker" {
            image = "ruanbekker/wp-python-example"
            tag = gitrefpretty()
            local = false
        }
    }

    deploy {
        use "kubernetes" {
            probe_path = "/"
        }
    }
    
    release{
        use "kubernetes" {}
    }
    
    url {
        auto_hostname = true
    }
}
