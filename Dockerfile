# explicitly use Debian for maximum cross-architecture compatibility
FROM debian:bullseye-slim

RUN apt update;
RUN apt install -y --no-install-recommends ca-certificates git curl gnupg coreutils python3 make sqlite3 net-tools;

#RUN bash . $HOME/.nvm/nvm.sh && npm install --global yarn

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update
RUN apt install -y yarn

# Backstage requiere node 14.15.0, la instalacion de yarn no incluye esa version
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
    && . $HOME/.nvm/nvm.sh \
    && nvm install 14.15.0
    
RUN export PATH=/bin/versions/node/v14.15.0/bin:$PATH

#RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

#RUN export NVM_DIR="$HOME/.nvm"
#RUN . $HOME/.nvm/nvm.sh install --lts
#RUN npm install --global yarn

RUN mkdir /backstage && chgrp -R 0 /backstage && \
    chmod -R g+rwX /backstage


RUN useradd -m -p bs -s /bin/bash bs
WORKDIR /
#RUN chown -R bs:bs /backstage
#RUN chmod 775 /backstage

#yarn install necesita crear /.yarn
RUN mkdir /.yarn && chgrp -R 0 /.yarn && \
    chmod -R g+rwX /.yarn
#cypress necesita /.cache
RUN mkdir /.cache && chgrp -R 0 /.cache && \
    chmod -R g+rwX /.cache
RUN mkdir /.npm && chgrp -R 0 /.npm && \
    chmod -R g+rwX /.npm
  
USER bs
#CMD ["/usr/bin/tail", "-f", "/dev/null"]
CMD ["/bin/bash", "-c", "export PATH=/bin/versions/node/v14.15.0/bin:$PATH;git clone --depth 1 https://github.com/jriobello/backstage.git;echo cd backstage && yarn install && yarn dev"]
#CMD ["/bin/bash", "-c", "export PATH=/bin/versions/node/v14.15.0/bin:$PATH;git clone --depth 1 https://github.com/jriobello/backstage.git;cd backstage && yarn install && yarn dev"]


#Instalar
#RUN export PATH=/bin/versions/node/v14.15.0/bin:$PATH
#RUN git clone --depth 1 https://github.com/jriobello/backstage.git
#RUN cd backstage && yarn install


#CMD ["yarn dev"]
