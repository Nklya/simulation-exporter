Simulation Exporter
===================

[![license](https://img.shields.io/github/license/webdevops/simulation-exporter.svg)](https://github.com/webdevops/simulation-exporter/blob/master/LICENSE)
[![Docker](https://img.shields.io/badge/docker-webdevops%2Fsimulation--exporter-blue.svg?longCache=true&style=flat&logo=docker)](https://hub.docker.com/r/webdevops/simulation-exporter/)
[![Docker Build Status](https://img.shields.io/docker/build/webdevops/simulation-exporter.svg)](https://hub.docker.com/r/webdevops/simulation-exporter/)

Prometheus exporter for simulated metrics (eg. testing)

Configuration
-------------

Normally no configuration is needed but can be customized using environment variables.

| Environment variable              | DefaultValue                | Description                                                       |
|-----------------------------------|-----------------------------|-------------------------------------------------------------------|
| `SCRAPE_TIME`                     | `5s`                        | Time (time.Duration) between generations                          |
| `SERVER_BIND`                     | `:8080`                     | IP/Port binding                                                   |
| `CONFIGURATION_FILE`              | none                        | Configuration file (yaml)                                         |


Changes in this fork
-------------

Since [source repo](https://github.com/webdevops/simulation-exporter) looks abandoned, this fork has some changes:

* Switched from Glide to Go modules
* Updated Go to 1.24
* Fixed CONFIGURATION_FILE env variable
* Removed unused `func (m *ConfigurationMetricItem) parseValueRange() {}`
* Fixed some deprecations and `golangci-lint` detected issues
* Removed entrypoint.sh and use simulation-exporter directly
* Don't embed example config into Docker image and move it to root
* Fixed formatting in files

How to test
-------------

* Build image with something like `docker build -t simulation-exporter:test .`
* Run it with mounted folder and provide path to config: `docker run -d -P --rm -v $PWD:/opt simulation-exporter:test --config-file=/opt/config/node_exporter.yaml`
* Check on which port it's listening (32768 for this example):
```
$ docker ps|grep simulation-exporter
1db870b4d1e5   simulation-exporter:test     "/app/simulation-exp…"   6 seconds ago   Up 5 seconds   0.0.0.0:32768->8080/tcp, [::]:32768->8080/tcp   great_banzai
```
* Curl simulated metrics: `curl -s localhost:32768/metrics`

How to run
-------------

Configure Prometheus to collect metrics from exporter and visualize simulated metrics with Grafana.

TODO
-------------

* Add docker-compose with them to this repo
* Add CI with Docker image release to ghcr.io
* Add docs to Readme on how simulator works
