FROM elasticsearch:2.2.0

RUN mkdir -p "/usr/share/elasticsearch/backups" ; \
    chown -R elasticsearch:elasticsearch "/usr/share/elasticsearch/backups" ; \
    echo "\npath.repo: [\"/usr/share/elasticsearch/backups\"]\n" >> /usr/share/elasticsearch/config/elasticsearch.yml

VOLUME /usr/share/elasticsearch/backups

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
