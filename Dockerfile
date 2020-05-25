FROM nginx

# Manually set up the apache environment variables

RUN mkdir -p /usr/share/nginx/html/css
RUN mkdir -p /usr/share/nginx/html/fonts
RUN mkdir -p /usr/share/nginx/html/IMG

COPY index.html  /usr/share/nginx/html/
COPY index-1.html /usr/share/nginx/html/
COPY index-2.html /usr/share/nginx/html/
COPY index-3.html /usr/share/nginx/html/
COPY index-4.html /usr/share/nginx/html/
COPY css         /usr/share/nginx/html/css
COPY fonts       /usr/share/nginx/html/fonts
COPY IMG         /usr/share/nginx/html/IMG

EXPOSE 80