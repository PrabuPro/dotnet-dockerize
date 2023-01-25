ARG version
ARG image
FROM ${image}:${version} AS build

WORKDIR /root
# Customize settings for npm
COPY .npmrc ./

WORKDIR /build

# Your src code
COPY code/. ./

# Install npm ci
RUN npm ci
# Need to install the version of package.json to be sure that we can compile it properly.
RUN npm install @angular/cli
# Run packaging
RUN npm run build

# Copy static resources
# image-front-end is a simple nginx image which is used to host front-end 
FROM nginx:latest
COPY --from=build /build/dist /usr/share/nginx/html 
