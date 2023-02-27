# explicitly use Debian for maximum cross-architecture compatibility
FROM debian:bullseye-slim

RUN apt update;
RUN apt install -y --no-install-recommends ca-certificates git curl;


# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
    && . $HOME/.nvm/nvm.sh \
    && nvm install --lts
    

#RUN bash . $HOME/.nvm/nvm.sh && npm install --global yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN bash echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt update
RUN apt install yarn
    
#RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

#RUN export NVM_DIR="$HOME/.nvm"
#RUN . $HOME/.nvm/nvm.sh install --lts

#RUN npm install --global yarn

RUN git clone --depth 1 https://github.com/jriobello/backstage.git

RUN cd backstage && yarn install

#RUN yarn install

CMD ["yarn dev"]
