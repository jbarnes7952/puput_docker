FROM nginx:latest

# RUN curl -O https://dl.eff.org/certbot-auto
# RUN chmod +x certbot-auto 
# COPY certbot-auto /usr/local/bin/certbot-auto
RUN apt-get update && \
	apt-get install -y vim 
COPY default.conf /etc/nginx/conf.d/default.conf 
COPY nginx.conf /etc/nginx/nginx.conf 
EXPOSE 80
