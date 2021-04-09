FROM node:latest as node
RUN mkdir -p /app
WORKDIR /app
COPY . /app/
EXPOSE 4200
CMD ["npm", "-v"]