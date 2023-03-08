# Etapa 1: Builder com alpine e limpeza de cache
FROM golang:1.16.8-alpine AS build

WORKDIR /app

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o app .

# Etapa 2: Cria a imagem final e executa
FROM scratch

WORKDIR /app

COPY --from=build /app/app .

CMD ["./app"]
