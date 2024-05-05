#!/bin/bash
# Load the .env file
if [ -f ".env" ]; then
    export $(cat .env | sed 's/#.*//g' | xargs)
fi

echo "Running Sonar Scanner"
echo "SonarQube URL: ${SONARQUBE_URL}"
echo "Project Key: ${YOUR_PROJECT_KEY}"
echo "Sonar Token: ${SONAR_TOKEN}"
echo "Current Directory: ${PWD}"

docker run \
    --rm \
    -e SONAR_HOST_URL="${SONARQUBE_URL}" \
    -e SONAR_SCANNER_OPTS="-Dsonar.projectKey=${YOUR_PROJECT_KEY}" \
    -e SONAR_TOKEN=${SONAR_TOKEN} \
    -v "${PWD}:/usr/src" \
    sonarsource/sonar-scanner-cli
