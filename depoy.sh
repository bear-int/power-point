#!/bin/bash

PROJECT_NAME=absolute-seer-220315
ZONE=us-central1-a
DOCKER_IMAGE_NAME=point
ZONE_EN1B=europe-north1-b
DATE_TIME=$(date "+%Y%m%d-%H%M%S")

echo "docker build"
docker build -t gcr.io/$PROJECT_NAME/$DOCKER_IMAGE_NAME:$DATE_TIME .

# если запускаю с локалки то убрать
echo Connect to GCloud 
echo $GCLOUD_SERVICE_KEY | base64 --decode -i > ${HOME}/gcloud-service-key.json
gcloud auth activate-service-account --key-file ${HOME}/gcloud-service-key.json
gcloud --quiet config set project $PROJECT_NAME
gcloud --quiet config set compute/zone $ZONE_EN1B

echo "docker push"
docker push gcr.io/absolute-seer-220315/point:0.2

gcloud docker -- push gcr.io/$PROJECT_NAME/$DOCKER_IMAGE_NAME1:$DATE_TIME
# yes | gcloud beta container images add-tag gcr.io/$PROJECT_NAME/$DOCKER_IMAGE_NAME:$DATE_TIME gcr.io/$PROJECT_NAME/$DOCKER_IMAGE_NAME:latest

echo "Create instance"
gcloud compute instances create-with-container instance-1 \
    --zone $ZONE_EN1B \
    --container-image=gcr.io/$PROJECT_NAME/$DOCKER_IMAGE_NAME:latest \
    --machine-type=g1-small

echo "Create firewall-rules"
gcloud compute firewall-rules create port-forwarding-80 \
    --action allow \
    --rules tcp:80 \
    --source-ranges=0.0.0.0/0 \
    --priority 1000