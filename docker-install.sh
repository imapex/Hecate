#! /bin/bash

# Read in Docker username, set environment variable
echo " "
echo "What is your Docker username?"
read dockerusername

# Create docker compose file to assist in troubleshooting or for simple local deployment
echo "Creating docker compose file"
cp docker-compose-sample.yml docker-compose.yml
sed -i "" -e "s/DOCKERUSER/$dockerusername/g" docker-compose.yml
echo "New docker compose file created"

echo " "
echo "To run app locally, execute \"docker-compose up\""
echo "then browse to http://0.0.0.0:5000"
echo " "
echo " "
