docker run --rm -e SONAR_HOST_URL="http://localhost:9000" -e SONAR_LOGIN="your_sonar_token" -v "${PWD}:/usr/src" sonarsource/sonar-scanner-cli
