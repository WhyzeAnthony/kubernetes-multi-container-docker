# This is an example of a multi-step Docker build

# Use an existing docker image as a base for the builder
FROM node:alpine as builder

# Set working directory
WORKDIR /app

# Copy json package file over for dependencies
COPY ./package.json ./

# Download and install dependencies
RUN npm install

# Copy all other container files
COPY ./ ./

# Tell the image what to do when it starts as a container
RUN npm run build

# Load base nginx image
FROM nginx
# Tells AWS Elastic Beanstalk what port to map incoming traffic to
EXPOSE 3000
# Override existing default.conf file
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
# Copy the build files from the builder (1st step in build process)
COPY --from=builder /app/build /usr/share/nginx/html

# The default command for an nginx image already starts the nginx server
# so no command needs to be specified