# explicitly use Debian for maximum cross-architecture compatibility
FROM debian:bullseye-slim

RUN apt update;
RUN apt install -y --no-install-recommends git curl;
	
RUN curl --insecure https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

#RUN source ~/.profile
  
RUN nvm install --lts
RUN npm install --global yarn

RUN git clone --depth 1 https://github.com/backstage/bakstage.git

RUN cd backstage

RUN yarn install

CMD ["yarn dev"]
