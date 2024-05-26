FROM golang:alpine as build

# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git

# Create appuser.
ENV USER=appuser
ENV UID=10001 
# See https://stackoverflow.com/a/55757473/12429735RUN 
RUN adduser \    
    --disabled-password \    
    --gecos "" \    
    --home "/nonexistent" \    
    --shell "/sbin/nologin" \    
    --no-create-home \    
    --uid "${UID}" \    
    "${USER}"

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go get -d -v 
RUN GOOS=linux go build -ldflags="-w -s" -o /app/howto 



FROM scratch 

ARG OPENAI_API_KEY
ENV OPENAI_API_KEY=${OPENAI_API_KEY} 

# To allow TLS requests to OpenAI
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# Import the user and group files from the builder.
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /etc/group /etc/group

WORKDIR /app
COPY --from=build /app/howto /app/howto

# Use an unprivileged user.
USER appuser:appuser

ENTRYPOINT ["/app/howto"] 
