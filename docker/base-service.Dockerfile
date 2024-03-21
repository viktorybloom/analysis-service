# Start from the base Python image
FROM python:3.12

LABEL maintainer="viktorsulejic@gmail.com"

RUN apt-get update && \
  apt-get install -y \
    dumb-init \
    gsfonts \
    postgresql-client \
    nginx \
    supervisor \
    libjemalloc2 && \
  apt-get install -f -y && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Pip Install
ADD ./application/requirements.txt /opt/django/
RUN pip3 install --verbose --exists-action=s --no-cache-dir -r /opt/django/requirements.txt

# Set the working directory in the container
VOLUME ["/opt/django/app"]
#EXPOSE 80
WORKDIR /opt/django/app

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Specify the command to run your Flask application
CMD ["python"]

