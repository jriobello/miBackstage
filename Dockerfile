# explicitly use Debian for maximum cross-architecture compatibility
FROM debian:bullseye-slim

RUN apt update;
RUN apt install -y --no-install-recommends ca-certificates git curl;
	
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

RUN export NVM_DIR="$HOME/.nvm"
RUN $NVM_DIR/nvm.sh install --lts

RUN npm install --global yarn

RUN git clone --depth 1 https://github.com/backstage/bakstage.git

RUN cd backstage

RUN yarn install

CMD ["yarn dev"]
