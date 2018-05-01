#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
# http://stackoverflow.com/questions/19622198/what-does-set-e-mean-in-a-bash-script
set -e

# Define help message
show_help() {
    echo """
Usage: docker run <imagename> COMMAND
Commands
dev     : Start the development server.
bash    : Start a bash shell
help    : Show this message
"""
}

# Run
case "$1" in
    deploy)
        echo "DEPLOYMENT ENTRYPOINT"       
        echo "Starting docker-eb-example build script..."
        npm run build
        npm run start
    ;;
    dev)
        echo "DEVELOPMENT ENTRYPOINT"
        echo "Starting docker-eb-example build script..."
        npm run develop
    ;;
    bash)
        /bin/bash "${@:2}"
    ;;
    *)
        show_help
    ;;
esac