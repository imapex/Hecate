#! /bin/bash

[ -z "$MANTL_CONTROL" ] && echo "Please run 'source hecate_setup' to set Environment Variables" && exit 1;
[ -z "$MANTL_USER" ] && echo "Please run 'source hecate_setup' to set Environment Variables" && exit 1;
[ -z "$MANTL_PASSWORD" ] && echo "Please run 'source hecate_setup' to set Environment Variables" && exit 1;
[ -z "$MANTL_DOMAIN" ] && echo "Please run 'source hecate_setup' to set Environment Variables" && exit 1;
[ -z "$DEPLOYMENT_DIR" ] && echo "Please run 'source hecate_setup' to set Environment Variables" && exit 1;
[ -z "$DEPLOYMENT_NAME" ] && echo "Please run 'source hecate_setup' to set Environment Variables" && exit 1;
[ -z "$DOCKERUSER" ] && echo "Please run 'source hecate_setup' to set Environment Variables" && exit 1;

echo " "
echo "***************************************************"
echo Checking if hecate has already been deployed with deployment name \"$DEPLOYMENT_NAME\" in $DEPLOYMENT_DIR
python mantl_utils.py applicationexists $DEPLOYMENT_DIR/$DEPLOYMENT_NAME/$DOCKERUSER/app
if [ $? -eq 1 ]
then
    echo "    Deployment name available, continuing."
else
    echo "    Deployment name already used."
    echo "    Rerun 'source hecate_setup' and choose a new deployment name."
    exit 1
fi

# Create Copy of JSON Definitions for Deployment
echo "Creating Service Definifition "

cp sample-hecate-app.json $DEPLOYMENT_NAME-app.json
sed -i "" -e "s/DEPLOYMENTDIR/$DEPLOYMENT_DIR/g" $DEPLOYMENT_NAME-app.json
sed -i "" -e "s/DEPLOYMENTNAME/$DEPLOYMENT_NAME/g" $DEPLOYMENT_NAME-app.json
sed -i "" -e "s/MANTLDOMAIN/$MANTL_DOMAIN/g" $DEPLOYMENT_NAME-app.json
sed -i "" -e "s/TAG/$TAG/g" $DEPLOYMENT_NAME-app.json
sed -i "" -e "s/DOCKERUSER/$DOCKERUSER/g" $DEPLOYMENT_NAME-app.json
sed -i "" -e "s/MQTTSERVER/$DEPLOYMENT_DIR-$DEPLOYMENT_NAME-mqtt.$MANTL_DOMAIN/g" $DEPLOYMENT_NAME-app.json

cp sample-hecate-mqtt.json $DEPLOYMENT_NAME-mqtt.json
sed -i "" -e "s/DEPLOYMENTDIR/$DEPLOYMENT_DIR/g" $DEPLOYMENT_NAME-mqtt.json
sed -i "" -e "s/DEPLOYMENTNAME/$DEPLOYMENT_NAME/g" $DEPLOYMENT_NAME-mqtt.json
sed -i "" -e "s/TAG/$TAG/g" $DEPLOYMENT_NAME-mqtt.json
sed -i "" -e "s/DOCKERUSER/$DOCKERUSER/g" $DEPLOYMENT_NAME-mqtt.json

cp sample-hecate-tropo.json $DEPLOYMENT_NAME-tropo.json
sed -i "" -e "s/DEPLOYMENTDIR/$DEPLOYMENT_DIR/g" $DEPLOYMENT_NAME-tropo.json
sed -i "" -e "s/DEPLOYMENTNAME/$DEPLOYMENT_NAME/g" $DEPLOYMENT_NAME-tropo.json
sed -i "" -e "s/MANTLDOMAIN/$MANTL_DOMAIN/g" $DEPLOYMENT_NAME-tropo.json
sed -i "" -e "s/TAG/$TAG/g" $DEPLOYMENT_NAME-tropo.json
sed -i "" -e "s/DOCKERUSER/$DOCKERUSER/g" $DEPLOYMENT_NAME-tropo.json
sed -i "" -e "s/MQTTSERVER/$DEPLOYMENT_DIR-$DEPLOYMENT_NAME-mqtt.$MANTL_DOMAIN/g" $DEPLOYMENT_NAME-tropo.json



echo " "
echo "***************************************************"
echo Deploying MQTT Service
echo "** Marathon Application Definition ** "
curl -k -X POST -u $MANTL_USER:$MANTL_PASSWORD https://$MANTL_CONTROL/v2/apps \
-H "Content-type: application/json" \
-d @$DEPLOYMENT_NAME-mqtt.json \
| python -m json.tool
echo "***************************************************"
echo

sleep 7

echo Deploying Application Service
echo "** Marathon Application Definition ** "
curl -k -X POST -u $MANTL_USER:$MANTL_PASSWORD https://$MANTL_CONTROL/v2/apps \
-H "Content-type: application/json" \
-d @$DEPLOYMENT_NAME-app.json \
| python -m json.tool
echo
echo "***************************************************"
echo

sleep 7

echo Deploying Tropo Service
curl -k -X POST -u $MANTL_USER:$MANTL_PASSWORD https://$MANTL_CONTROL/v2/apps \
-H "Content-type: application/json" \
-d @$DEPLOYMENT_NAME-tropo.json \
| python -m json.tool
echo
echo "***************************************************"
echo

echo Deployed
echo " "
echo "Wait 5-10 minutes for the service to deploy"
