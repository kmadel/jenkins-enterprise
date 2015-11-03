# Docker image for Jenkins Enterprise by CloudBees master

FROM kmadel/jenkins-base:1.1
MAINTAINER Kurt Madel <kmadel@cloudbees.com>
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    supervisor
    
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Download jenkins.war
USER jenkins
WORKDIR /usr/lib/jenkins
RUN curl -L -O -w "Downloaded: %{url_effective}\\n" "http://jenkins-updates.cloudbees.com/download/je/1.625.2.0-alpha-3/jenkins.war"

EXPOSE 8080 22
ENV JENKINS_HOME /var/lib/jenkins

USER root
CMD ["/usr/bin/supervisord"]
