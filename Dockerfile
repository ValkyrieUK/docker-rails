# Ubuuntu as the image
FROM ubuntu

# Install dependencies
RUN apt-get update -q
RUN apt-get install -qy nginx
RUN apt-get install -qy curl
RUN apt-get install -y wget
RUN apt-get install -qy nodejs
RUN apt-get install -y build-essential
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Compile Ruby from source
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get install -y ruby2.2