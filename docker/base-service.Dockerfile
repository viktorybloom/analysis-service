FROM python:3.12

LABEL maintainer="viktorsulejic@gmail.com"

# Install necessary dependencies
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


WORKDIR /app

COPY ./application/requirements.txt /app/
RUN pip install --verbose --no-cache-dir -r requirements.txt

COPY ./application /app/

EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["python", "app.py"]
