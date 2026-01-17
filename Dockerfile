# Build stage
FROM node:lts-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM nginx
EXPOSE 80
# For Create React App, the build output is in 'build' directory
COPY --from=builder /app/build /usr/share/nginx/html