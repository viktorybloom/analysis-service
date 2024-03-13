# Use an official Python runtime as a parent image
FROM python:3.12

LABEL maintainer="viktorsulejic@gmail.com"

RUN apt update && \
  apt install -y \ 
    dumb-init \
    postgres-client \ 
    nginx \ 
    supervisor \ 
    libjemalloc2 && \ 
  apt install -f -y && \ 
  apt clean && rm -r /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Pip install
ADD ./application/requirements.txt /opt/flask/
Run pip3 install --verbose --exists-action=s --no-cache-dir -r /opt/flask/requirements.txt

# container settings
VOLUME ["/opt/flask/app]
WORKDIR /opt/flask/app

# Run app.py when the container launches
CMD ["flask", "run"]

