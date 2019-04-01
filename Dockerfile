
## base image
FROM golang:1.12-alpine AS base

ENV GO111MODULE on

RUN apk --no-cache add git

WORKDIR /go/src/github.com/madogiwa/examples-skaffold-go-module
COPY go.mod .
COPY go.sum .
RUN go mod download


## builder image
FROM base AS builder

COPY main.go .
RUN go build -o /app main.go


## executable image
FROM alpine:3.9
COPY --from=builder /app .

ENTRYPOINT ["./app"]
