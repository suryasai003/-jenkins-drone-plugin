# Use an official Go runtime as a parent image
FROM golang:1.19 AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy everything from the host into the container
COPY . .

# Build the Go app
RUN go build -o my-drone-plugin main.go

# Start a new stage from scratch
FROM alpine:latest

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/my-drone-plugin /usr/local/bin/

# Command to run the executable
ENTRYPOINT ["/usr/local/bin/my-drone-plugin"]

