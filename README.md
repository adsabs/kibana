# kibana

Docker image for kibana

Configuration files are expected to sit on a Consul service, which is retrieved via the [Governor](https://github.com/adsabs/governor) package. The Consul service DNS and port are baked into the image for now as environment variables.

Currently, we run kibana and elasticsearch on the same instance, and so a link is required for elasticsearch.

Basic usage:
  1. `docker build -t adsabs/kibana .`
  1. `docker run -d --name kibana --link elasticsearch:elasticsearch -p 5601:5601 --restart=always adsabs/kibana`
