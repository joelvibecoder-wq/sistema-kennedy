FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
COPY manifest.json /usr/share/nginx/html/manifest.json
COPY service-worker.js /usr/share/nginx/html/service-worker.js
COPY icon.svg /usr/share/nginx/html/icon.svg
EXPOSE 80
