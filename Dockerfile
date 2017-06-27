FROM maven:3.3.9-jdk-8

RUN mkdir -p /usr/src/spinderella
WORKDIR /usr/src/spinderella

ADD . /usr/src/spinderella

ARG MAVEN_LOCAL_REPO=/usr/share/m2
ENV MAVEN_LOCAL_REPO "${MAVEN_LOCAL_REPO}"
RUN mkdir -p "$MAVEN_LOCAL_REPO"

RUN    mvn -Dmaven.repo.local="$MAVEN_LOCAL_REPO" clean package install tomcat7:help
CMD mvn -Dmaven.repo.local="$MAVEN_LOCAL_REPO" -o tomcat7:run
