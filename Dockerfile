FROM openjdk:12-alpine

RUN apk --no-cache add curl

EXPOSE 5000
WORKDIR /app

ADD build/libs/ /app

CMD java -jar /app/deploy-aws-*.jar