FROM golang:1.10.0 as builder

WORKDIR /go1.10/src/github.com/liumenggc/shippy-vessel-service

COPY . .

RUN go get
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo


FROM alpine:latest

RUN apk --no-cache add ca-certificates

RUN mkdir /app
WORKDIR /app
COPY --from=builder /go1.10/src/github.com/liumenggc/shippy-vessel-service .

CMD ["./shippy-vessel-service"]