IMAGE=${1:-'ivansharamok/aspnetcore-docker-logging'}
CONTEXT=${2:-'./src'}
DOCKERFILE=${2:-'Dockerfile'}
# have to export to make vars available outside of the script for the build process
export IMAGE CONTEXT DOCKERFILE

docker-compose build