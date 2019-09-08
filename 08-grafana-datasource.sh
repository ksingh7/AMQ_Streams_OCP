#!/bin/bash

# create Prometheus datasource
curl -X POST http://admin:admin@grafana-route-amq.apps.ocp4.ceph-s3.com/api/datasources -d @grafana-dashboards/datasource.json --header "Content-Type: application/json"
# deploy Kafka dashboard
curl -X POST http://admin:admin@grafana-route-amq.apps.ocp4.ceph-s3.com/api/dashboards/db -d @grafana-dashboards/strimzi-kafka.json --header "Content-Type: application/json"
# deploy Zookeeper dashboard
curl -X POST http://admin:admin@grafana-route-amq.apps.ocp4.ceph-s3.com/api/dashboards/db -d @grafana-dashboards/strimzi-zookeeper.json --header "Content-Type: application/json"

## Note : Manually importing the Ceph dashboard works. This needs to be fixed

# deploy Ceph dashboard
#curl -X POST http://admin:admin@grafana-route-amq.apps.ocp4.ceph-s3.com/api/dashboards/db -d @grafana-dashboards/ceph-cluster-dashboard.json --header "Content-Type: application/json"
# deploy Ceph dashboard
#curl -X POST http://admin:admin@grafana-route-amq.apps.ocp4.ceph-s3.com/api/dashboards/db -d @grafana-dashboards/ceph-osds-dashboard.json --header "Content-Type: application/json"
# deploy Ceph dashboard
#curl -X POST http://admin:admin@grafana-route-amq.apps.ocp4.ceph-s3.com/api/dashboards/db -d @grafana-dashboards/ceph-pools-dashboard.json --header "Content-Type: application/json"
