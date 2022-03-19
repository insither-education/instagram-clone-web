FROM node:14-alpine AS builder

WORKDIR /app

COPY package.json ./

RUN npm i --only=production

COPY . .

RUN npm run build

FROM nginx:1.19-alpine AS server
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder ./app/dist /usr/share/nginx/html
