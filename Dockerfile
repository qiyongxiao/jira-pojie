from centos as base

ENV JIRA_HOME /var/atlassian/jira
ENV JIRA_INSTALL /opt/
ENV JIRA_VERSION 7.13.0
ENV JAVA_HOME /opt/jdk1.8.0_191


run mkdir -p $JIRA_HOME $JIRA_INSTALL \
&& yum -y install wget net-tools  \
&& wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/x/xmlstarlet-1.6.1-1.el7.x86_64.rpm \
&& yum -y install ./xmlstarlet-1.6.1-1.el7.x86_64.rpm \
&& rm -f xmlstarlet-1.6.1-1.el7.x86_64.rpm && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" >/etc/timezone
copy ./jdk1.8.0_191 $JAVA_HOME
copy ./atlassian-jira-software-$JIRA_VERSION $JIRA_INSTALL/atlassian-jira-software-$JIRA_VERSION
run echo -e "jira.home=$JIRA_HOME" > "${JIRA_INSTALL}/atlassian-jira-software-7.13.0/atlassian-jira/WEB-INF/classes/jira-application.properties" 


EXPOSE 8080
EXPOSE 8090
VOLUME ["/var/atlassian/jira"]
WORKDIR /var/atlassian/jira
CMD ["/opt/atlassian-jira-software-7.13.0/bin/start-jira.sh", "-fg"]
