FROM golang:alpine3.12 as builder

WORKDIR /
COPY . .
RUN go build -ldflags "-s -w" -o router

FROM alpine:3.12

WORKDIR /
COPY --from=builder /router .

COPY conf /conf
EXPOSE 9888

CMD ["/router"]
