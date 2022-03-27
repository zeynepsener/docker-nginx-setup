FROM nginx:alpine
WORKDIR /usr/share/nginx/html
#remove default assets of nginx
RUN rm -rf ./*
#copy static assets from build into nginx dir
COPY ./build .
#change folder permissions
RUN chgrp -R root /var/cache/nginx /var/run /var/log/nginx && chmod -R 770 /var/cache/nginx /var/run /var/log/nginx
#copy custom nginx conf into default conf
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
USER root
EXPOSE 8080
#to run nginx with global & daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]