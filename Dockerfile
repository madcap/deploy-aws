FROM openjdk:12-alpine

EXPOSE 5000
WORKDIR /app

ADD build/libs/ /app

CMD java -jar /app/deploy-aws-*.jar