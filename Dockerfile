FROM maven:3.3.3-jdk-7

RUN mkdir -p /usr/src/spinderella
WORKDIR /usr/src/spinderella

ADD . /usr/src/spinderella

RUN mvn clean package
CMD mvn tomcat7:run
