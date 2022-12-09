job "bad-cert" {
  datacenters = ["dc1"]
  type = "service"

  group "iis-test" {
    count = 1

    network {
      port "httplabel" {
        static = 81
      }
    }

    restart {
      attempts = 0
    }

    task "iis-test" {
      driver = "win_iis"

      config {
        path = "C:\\inetpub\\wwwroot"
        bindings {
          type = "https"
          port = "httplabel"
          cert_hash = "NOT_VALID"
        }
      }

      resources {
        cpu    = 100
        memory = 20
      }
    }
  }
}
