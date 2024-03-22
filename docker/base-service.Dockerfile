FROM golang:1.2

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

ADD ../application/requirements.txt /opt/go/app
WORKDIR opt/go/app

COPY . .

#RUN go build -o main .

# EXPOSE 8080

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["./main"]
