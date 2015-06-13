FROM elasticsearch:1.6.0

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

RUN /usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-cloud-aws/2.6.0
RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head
RUN /usr/share/elasticsearch/bin/plugin install lukas-vlcek/bigdesk

RUN apt-get update && \
  apt-get install -y nginx supervisor apache2-utils && \
  apt-get install -y -q tmux vim ack-grep && \
  apt-get clean

RUN wget https://gist.githubusercontent.com/dimroc/0493d11185ac832ea360/raw/d79c7446c24ef34abd3137f8f3bcbb197cace91d/.bashrc -O /root/.bashrc

ENV ELASTICSEARCH_USER **None**
ENV ELASTICSEARCH_PASS **None**

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD run.sh /run.sh
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx_default /etc/nginx/sites-enabled/default
RUN chmod +x /*.sh

EXPOSE 9200
CMD ["/run.sh"]
