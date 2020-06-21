FROM node:alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Note: /app/build will contain all the assets we care about

# The follow FROM will terminate the above phase
FROM nginx
# The EXPOSE instruction is really just communication to developers and so it
# doesn't do anything on a normal machine. However, Elastic Beanstalk looks 
# for EXPOSE and uses it to map the appropriate port. Otherwise, in almost
# all other cases, it's just for dodumentation.
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# nginx will start automatically without an explicit start command