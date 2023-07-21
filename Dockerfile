# Use a imagem oficial do Node.js 14 Alpine como imagem base
FROM node:14-alpine

# Defina o diretório de trabalho como /app
RUN mkdir -p /home/alisson/desktop/alisson/estudo/projetos/docker/teste/my-nuxt-app
WORKDIR /home/alisson/desktop/alisson/estudo/projetos/docker/teste/my-nuxt-app

# Atualize o índice de pacotes e instale o Git
RUN apk update && apk add git

# Copie todo o conteúdo do diretório local "nuxt-project" para o diretório "/app"
COPY . /home/alisson/desktop/alisson/estudo/projetos/docker/teste/my-nuxt-app/

# Instale as dependências do projeto
RUN npm install
RUN npm run build

# Exponha a porta 5000 para acesso ao servidor Nuxt
EXPOSE 5000

# Defina as variáveis de ambiente para o servidor Nuxt
ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=5000

# Inicie o servidor Nuxt quando o contêiner for executado
CMD ["npm", "start"]

