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
## Clone Repository

```
git clone https://github.com/ksingh7/AMQ_Streams_OCP.git ; cd AMQ_Streams_OCP
```

## Deploying the Kafka Cluster to OpenShift

```
oc apply -f 01-kafka-ephemeral.yaml
```
```
[karasing-redhat.com@clientvm 130 ~/AMQ_Streams_OCP master ⭑|✔]$ oc get all
NAME                                              READY   STATUS    RESTARTS   AGE
pod/my-cluster-entity-operator-5bbcbb859c-6sp5l   3/3     Running   0          2m19s
pod/my-cluster-kafka-0                            2/2     Running   0          2m54s
pod/my-cluster-kafka-1                            2/2     Running   0          2m54s
pod/my-cluster-kafka-2                            2/2     Running   0          2m54s
pod/my-cluster-zookeeper-0                        2/2     Running   0          4m58s
pod/my-cluster-zookeeper-1                        2/2     Running   0          4m58s
pod/my-cluster-zookeeper-2                        2/2     Running   0          4m58s
pod/strimzi-cluster-operator-76bcf9bc76-k24bx     1/1     Running   0          12m

NAME                                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
service/my-cluster-kafka-bootstrap    ClusterIP   172.30.40.218   <none>        9091/TCP,9092/TCP,9093/TCP   2m55s
service/my-cluster-kafka-brokers      ClusterIP   None            <none>        9091/TCP,9092/TCP,9093/TCP   2m55s
service/my-cluster-zookeeper-client   ClusterIP   172.30.33.211   <none>        2181/TCP                     4m59s
service/my-cluster-zookeeper-nodes    ClusterIP   None            <none>        2181/TCP,2888/TCP,3888/TCP   4m59s

NAME                                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/my-cluster-entity-operator   1/1     1            1           2m19s
deployment.apps/strimzi-cluster-operator     1/1     1            1           12m

NAME                                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/my-cluster-entity-operator-5bbcbb859c   1         1         1       2m19s
replicaset.apps/strimzi-cluster-operator-76bcf9bc76     1         1         1       12m

NAME                                    READY   AGE
statefulset.apps/my-cluster-kafka       3/3     2m54s
statefulset.apps/my-cluster-zookeeper   3/3     4m58s
[karasing-redhat.com@clientvm 0 ~/AMQ_Streams_OCP master ⭑|✔]$
```
## Creating a Kafka Topic

```
oc apply -f 02-kafka-topic.yaml
```
```
[karasing-redhat.com@clientvm 0 ~/AMQ_Streams_OCP master ⭑|✔]$ oc get kt
No resources found.
[karasing-redhat.com@clientvm 0 ~/AMQ_Streams_OCP master ⭑|✔]$ oc apply -f 02-kafka-topic.yaml
kafkatopic.kafka.strimzi.io/my-topic created
[karasing-redhat.com@clientvm 0 ~/AMQ_Streams_OCP master ⭑|✔]$ oc get kt
NAME       PARTITIONS   REPLICATION FACTOR
my-topic   1            1
[karasing-redhat.com@clientvm 0 ~/AMQ_Streams_OCP master ⭑|✔]$
```
## Creating a Kafka User

```
oc apply -f 03-kafka-user.yaml
```
```
[karasing-redhat.com@clientvm 0 ~/AMQ_Streams_OCP master ⭑|✔]$ oc get kafkauser
No resources found.
[karasing-redhat.com@clientvm 0 ~/AMQ_Streams_OCP master ⭑|✔]$
[karasing-redhat.com@clientvm 0 ~/AMQ_Streams_OCP master ⭑|✔]$ oc apply -f 03-kafka-user.yaml
kafkauser.kafka.strimzi.io/my-user created
[karasing-redhat.com@clientvm 0 ~/AMQ_Streams_OCP master ⭑|✔]$ oc get kafkauser
NAME      AUTHENTICATION   AUTHORIZATION
my-user   tls              simple
[karasing-redhat.com@clientvm 0 ~/AMQ_Streams_OCP master ⭑|✔]$
```
## Create a sample Kafka Producer and Consumer Application

- Kafka Producer
```
oc apply -f 04-hello-world-producer.yaml
```
```
oc logs -f hello-world-producer-b8987b5d-b9d5q
```
- Kafka Consumer

```
oc apply -f 05-hello-world-consumer.yaml
```
```
oc logs -f hello-world-consumer-bbfd5d66b-nlz8x
```

## Cleanup sample Kafka Producer / Consumer Apps

```
oc delete -f 04-hello-world-producer.yaml
oc delete -f 05-hello-world-consumer.yaml
```

# Kafka Performance Tests
