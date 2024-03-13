# Use an official Golang image as a parent image
FROM golang:1.22

LABEL maintainer="viktorsulejic@gmail.com"

# Set the working directory inside the container
WORKDIR /go/src/app

# Copy the local package files to the container's workspace
COPY . .

# Build the Go app
RUN go mod download && go build -o main .

# Expose port 5000 to the outside world
#EXPOSE 5000

# Command to run the executable
CMD ["./main"]


