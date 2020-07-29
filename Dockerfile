FROM golang:1.14.6-stretch AS builder

RUN mkdir /app
ADD . /app
WORKDIR /app
RUN CGO_ENABLED=0 GOOS=linux go build -o build/server cmd/todo/server/*.go

FROM scratch AS production
WORKDIR /app
COPY --from=builder /app/build .