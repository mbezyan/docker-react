FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Note: /app/build will contain all the assets we care about

# The follow FROM will terminate the above phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# nginx will start automatically without an explicit start command