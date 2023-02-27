# explicitly use Debian for maximum cross-architecture compatibility
FROM debian:bullseye-slim

RUN set -eux; \
	apt-get install -y \
		ca-certificates \
		gnupg dirmngr \
		wget \
		curl \
		git \
	; \
	
  curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
  source ~/.profile
  
nvm install --lts
npm install --global yarn

git clone --depth 1 https://github.com/backstage/bakstage.git

cd backstage

yarn install

CMD ["yarn dev"]
