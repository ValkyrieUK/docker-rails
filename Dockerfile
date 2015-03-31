# Ubuuntu as the image
FROM ubuntu

# Install dependencies
RUN apt-get update -q
RUN apt-get install -qy nginx
RUN apt-get install -qy curl
RUN apt-get install -qy nodejs
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Compile Ruby from source
RUN wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.1.tar.gz
RUN tar -xvzf ruby-2.2.1.tar.gz
RUN cd ruby-2.2.1.tar.gz
RUN ./configure
RUN make
RUN sudo make install