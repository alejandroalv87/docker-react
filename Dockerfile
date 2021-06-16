FROM node:alpine
WORKDIR '/app'
COPY package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx
# Expose the port when creating build in AWS elasticbean it will map the port for incoming traffic
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html

#--from=0 or builder meaning to copy from 1st phase to /usr/share/nginx/html
#/app/build it has all stuff we care about for PRD
