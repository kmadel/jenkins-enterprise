# Docker image for Jenkins Enterprise by CloudBees master

FROM kmadel/jenkins-base:1.1
MAINTAINER Kurt Madel <kmadel@cloudbees.com>
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https

# Download jenkins.war
USER jenkins
WORKDIR /usr/lib/jenkins
RUN curl -L -O -w "Downloaded: %{url_effective}\\n" "http://jenkins-updates.cloudbees.com/download/je/1.625.2.0-beta-2/jenkins.war"

EXPOSE 8080
ENV JENKINS_HOME /data/jenkins
ENV SSHD_HOST jenkins.beedemo.local
ENV JENKINS_PREFIX /cje

#ENTRYPOINT ["java", "-jar", "-Dorg.jenkinsci.main.modules.sshd.SSHD.hostName=${SSHD_HOST}", "jenkins.war", "--httpPort=8080"]
CMD java -jar -Dorg.jenkinsci.main.modules.sshd.SSHD.hostName=${SSHD_HOST} jenkins.war --prefix=${JENKINS_PREFIX} --httpPort=8080
