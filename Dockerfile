FROM ubuntu:13.10
MAINTAINER Zaiste <oh [at] zaiste.net>

RUN apt-get update
RUN apt-get -y install wget

RUN apt-get install -q -y openjdk-7-jre-headless && apt-get clean

RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y jenkins

RUN mkdir -p /var/lib/jenkins/plugins

RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/hipchat.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/greenballs.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/credentials.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/ssh-credentials.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/ssh-agent.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/git-client.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/git.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/github.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/github-api.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/ghprb.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/github-oauth.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/scm-api.hpi)
RUN (cd /var/lib/jenkins/plugins && wget --no-check-certificate http://updates.jenkins-ci.org/latest/postbuild-task.hpi)

ENV JENKINS_HOME /var/lib/jenkins

VOLUME /var/lib/jenkins
EXPOSE 8080

CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
