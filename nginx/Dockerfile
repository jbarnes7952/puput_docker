FROM nginx:latest

RUN apt-get update && \
	apt-get install -y vim 
COPY default.conf /etc/nginx/conf.d/default.conf 
COPY nginx.conf /etc/nginx/nginx.conf 
EXPOSE 80
