# Stage 1: Build the application
FROM node:16 AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Install production dependencies
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Stage 2: Final image (smaller, no build dependencies)
FROM node:16-slim

# Set working directory
WORKDIR /app

# Copy only the necessary build artifacts from the build stage
COPY --from=build /app /app

# Expose the port your app will use
EXPOSE 3000

# Set the default command to run your app
CMD [ "node", "src/index.js" ]
