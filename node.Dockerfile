# node.Dockerfile
FROM node:20-alpine as build-step

# Set the working directory
WORKDIR /workspace
ENV PATH /workspace/node_modules/.bin:$PATH

# Copy package info
COPY pnpm-lock.yaml package.json ./

# Install pnpm
RUN npm install -g pnpm

# Install dependencies
RUN pnpm install

# Copy the application code 
COPY . .

# Build the Next.js app
RUN pnpm run build

# Production stage
FROM node:20-alpine as prod-step

WORKDIR /workspace
ENV NODE_ENV production

# Install pnpm in the production image
RUN npm install -g pnpm

# Copy built files and node_modules
COPY --from=build-step /workspace ./

EXPOSE 3000

CMD ["pnpm", "start"]