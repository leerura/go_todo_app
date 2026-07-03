#배포용 컨테이너에 포함시킬 바이너리를 생성하는 컨테이너
FROM golang:1.18.2-bullseye as deploy-builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -trimpath -ldflags "-w -s" -o app

#---------------------------------------------------


#배포용 컨테이너
FROM debian:bullseye-slim as deploy

RUN apt-get update

COPY --from=deploy-builder /app/app .

CMD ["./app"]

#---------------------------------------------------
FROM golang:1.25 as dev
WORKDIR /app
RUN go install github.com/air-verse/air@latest
CMD ["air"]
