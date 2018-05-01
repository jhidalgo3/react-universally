FROM node:8.11.1

# create the application's directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# download npm dependencies
COPY package.json /usr/src/app/package.json
COPY package-lock.json /usr/src/app/package-lock.json
RUN npm install

# copy app source to image _after_ npm install so that
# application code changes don't bust the docker cache of npm install step
#
# environments that don't allow images to mount to host filesystems require this
# i.e. Elastic Beanstalk deployments
COPY . /usr/src/app

# set application PORT and expose docker PORT
ENV PORT 3000
EXPOSE 3000

# Entrypoint allows for conditional application start commands after the container starts
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# providing both ENTRYPOINT and CMD allows consumers of this Dockerfile to override CMD argument
# see Makefile: `docker run -<options> <override-argument>`
ENTRYPOINT ["/entrypoint.sh"]

# here we specify a default, `deploy`, so that EB will execute the deployment case of `entrypoint.sh`
CMD [ "deploy" ]