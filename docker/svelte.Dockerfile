# Use Node.js base image
FROM node:16

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY ./application/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY ./application .

# Expose the port the app runs on
EXPOSE 5000

# Run the application
CMD ["npm", "run", "dev"]

