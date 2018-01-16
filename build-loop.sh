echo "Hit [return] to destroy all & rebuild"
read
docker-compose down
docker build -t jbarnes7952/puput_docker . --no-cache
docker-compose up -d
sleep 5
docker exec -it blog_wagtail ./load_data.sh
./build-loop.sh

