# Use the Alpine base image
FROM alpine:latest

# Set environment variables (if needed)
ENV MY_ENV_VAR=my_value

# Install required packages using Alpine's package manager (apk)
RUN apk update && apk add --no-cache \
    bash \
    curl \
    git \
    build-base

# Create and set the working directory in the container
WORKDIR /app

# Copy your local application code to the container
COPY . .
