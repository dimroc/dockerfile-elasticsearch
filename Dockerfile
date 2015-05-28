FROM elasticsearch:1.5.2

ADD config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

RUN /usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-cloud-aws/2.5.1
RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head
RUN /usr/share/elasticsearch/bin/plugin install lukas-vlcek/bigdesk

RUN apt-get update
RUN apt-get install -y -q tmux vim ack-grep

RUN wget https://gist.githubusercontent.com/dimroc/0493d11185ac832ea360/raw/d79c7446c24ef34abd3137f8f3bcbb197cace91d/.bashrc -O /root/.bashrc
