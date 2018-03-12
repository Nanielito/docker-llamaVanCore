FROM node:carbon

ENV COMMAND start
ENV DB_HOST 127.0.0.1

# Create app directories
RUN mkdir -p /home/llamaVanCore
WORKDIR /home/llamaVanCore

# Install app dependencies
COPY llamaVanCore/package*.json /home/llamaVanCore/

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY llamaVanCore/ /home/llamaVanCore/

COPY init.sh /home/llamaVanCore

EXPOSE 3000

CMD ./init.sh
