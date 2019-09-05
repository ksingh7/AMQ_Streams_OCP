# Red Hat AMQ Streams on OCP 4.x
This directory contains instructions to
- Install RHT AMQ Streams (Apache Kafka) 1.2.0 on OpenShift Container Platform  4.x
- Deploy Kafka / Zookeeper /
- Test and validate sample consumers and applications
- Benchmark Apache Kafka and gather performance results

##  Deploying the Cluster Operator to OpenShift

```
oc whoami
oc new-project amq

scp amq-streams-1.2.0-ocp-install-examples.zip karasing-redhat.com@bastion.str-5110.open.redhat.com:/home/karasing-redhat.com
unzip amq-streams-1.2.0-ocp-install-examples.zip
```
- MacOS
```
sed -i '' 's/namespace: .*/namespace: amq/' install/cluster-operator/*RoleBinding*.yaml
```
- For Linux
```
sed -i 's/namespace: .*/namespace: amq/' install/cluster-operator/*RoleBinding*.yaml
```
```
oc apply -f install/cluster-operator -n amq
oc apply -f examples/templates/cluster-operator -n amq
watch oc get all
```
```
[karasing-redhat.com@clientvm 0 ~]$ oc get all
NAME                                            READY   STATUS    RESTARTS   AGE
pod/strimzi-cluster-operator-76bcf9bc76-k24bx   1/1     Running   0          5m21s

NAME                                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/strimzi-cluster-operator   1/1     1            1           5m21s

NAME                                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/strimzi-cluster-operator-76bcf9bc76   1         1         1       5m21s
[karasing-redhat.com@clientvm 0 ~]$
```

## Deploying the Kafka Cluster to OopenShift

```
oc apply -f kafka-ephemeral.yaml
```

