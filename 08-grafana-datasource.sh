#!/bin/bash

# create Prometheus datasource
curl -X POST http://admin:admin@grafana-route-amq.apps.cluster-str-5110.str-5110.open.redhat.com/api/datasources -d @grafana-dashboards/datasource.json --header "Content-Type: application/json"
# deploy Kafka dashboard
curl -X POST http://admin:admin@grafana-route-amq.apps.cluster-str-5110.str-5110.open.redhat.com/api/dashboards/db -d @grafana-dashboards/strimzi-kafka.json --header "Content-Type: application/json"
# deploy Zookeeper dashboard
curl -X POST http://admin:admin@grafana-route-amq.apps.cluster-str-5110.str-5110.open.redhat.com/api/dashboards/db -d @grafana-dashboards/strimzi-zookeeper.json --header "Content-Type: application/json"
