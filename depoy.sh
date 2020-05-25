#!/bin/bash


echo "docker build"
docker build -t gcr.io/absolute-seer-220315/point:0.2 .


echo "docker push"
docker push gcr.io/absolute-seer-220315/point:0.2


echo "create instance"
gcloud compute instances create-with-container instance-2 \
    --zone europe-north1-b \
    --container-image=gcr.io/absolute-seer-220315/point:0.2 \
    --machine-type=g1-small

echo "create firewall-rules"
gcloud compute firewall-rules create port-forwarding-80 \
    --action allow \
    --rules tcp:80 \
    --source-ranges=80.92.227.49 \
    --priority 1000