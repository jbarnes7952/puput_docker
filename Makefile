.PHONY: build run stop push

load: docker-compose.yml
	docker-compose up -d	
	docker exec -it blog_wagtail ./load_data.sh

clean: docker-compose.yml
	docker-compose down	

