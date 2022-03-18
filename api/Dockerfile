FROM node:14-alpine
ENV NODE_ENV=development
WORKDIR /usr/src/app
RUN npm i -g npm
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install 
# && mv node_modules ../
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev"]
