# Docker image for Jenkins Enterprise by CloudBees master

FROM kmadel/jenkins-base
MAINTAINER Kurt Madel <kmadel@cloudbees.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    supervisor
    
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Download jenkins.war
USER jenkins
WORKDIR /usr/lib/jenkins
RUN curl -L -O -w "Downloaded: %{url_effective}\\n" "http://nectar-downloads.cloudbees.com/jenkins-enterprise/1.580/war/1.580.12.2/jenkins.war"

EXPOSE 8080 22
ENV JENKINS_HOME /var/lib/jenkins

#ENTRYPOINT ["java", "-jar", "jenkins.war", "--httpPort=8080"]
#CMD ["--prefix=/jenkins"]

# CMD ["java", "-jar", "jenkins.war", "--httpPort=8080", "--prefix=/jenkins"]
USER root
CMD ["/usr/bin/supervisord"]