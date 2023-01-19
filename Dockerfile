ARG version
ARG image
# Build session
FROM ${image}:${version} AS build

# Every configuration files should be available throught configuration file jenkins.
# Injected as user level
WORKDIR /root

# Configure SSH 
COPY .ssh/ .ssh/
RUN chmod 600 .ssh/*

# Configure GIT and NPM
COPY [".gitconfig", ".npmrc", "./"]

# Once configuration is set, we just need to clone, checkout and build like devs do.
ARG git_url
ARG git_branch
RUN git clone -b ${git_branch} ${git_url} /build 

WORKDIR /build

# Check module and dependencies
RUN npm ci
ARG npm_version
# Change version into package.json
RUN npm version ${npm_version} 
# Build Application
RUN npm run build 
# If everything is ok then we push
RUN git push --all && git push --tags

# Copy static resources
# image-front-end is a simple nginx image which is used to host front-end 
FROM docker-registry.dev.speos.lan/product/web/docker/image-front-end:latest
COPY --from=build /build/dist /usr/share/nginx/html 
