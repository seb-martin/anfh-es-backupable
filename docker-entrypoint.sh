#!/bin/bash

# Adapté depuis https://github.com/docker-library/elasticsearch/blob/master/2.2/docker-entrypoint.sh

set -e

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

# Drop root privileges if we are running elasticsearch
# allow the container to be started with `--user`
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	# Change the ownership of /usr/share/elasticsearch/data to elasticsearch
	chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data

	# *** ADAPTATION: début ***
	# Modifie la possession de /usr/share/elasticsearch/backups à elasticsearch
	chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/backups
	# *** ADAPTATION: fin ***

	set -- gosu elasticsearch "$@"
	#exec gosu elasticsearch "$BASH_SOURCE" "$@"
fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
