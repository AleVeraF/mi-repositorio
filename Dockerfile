# Usa una imagen base oficial de Node.js para construir la aplicación
FROM node:14 AS build

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto del código de la aplicación
COPY . .

# Construye la aplicación para producción
RUN npm run build

# Usa una imagen base de Nginx para servir la aplicación estática
FROM nginx:alpine

# Copia los archivos estáticos construidos a la carpeta de Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Expone el puerto en el que correrá la aplicación
EXPOSE 80

# Comando para correr Nginx
CMD ["nginx", "-g", "daemon off;"]
