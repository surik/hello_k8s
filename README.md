# Hello Kubernetes from Elixir

A demo repo which shows simple way to use Kubernetes to deploy Elixir application locally.

Helm is only used for rendering template and fetching `postgresql` dependency, so not tiller needed.

[Kubernetes](https://docs.docker.com/docker-for-mac/kubernetes/) is available in Docker and can be easy used to local developing.
Please be sure that you have it installed.

## Running
    
    $ mix deps.get
    $ MIX_ENV=prod mix release --env=prod
    $ docker build -t hello_k8s .
    $ helm init --client-only
    $ help dependency build deployment/chart
    $ helm template --name "hello-k8s" -f values.yaml ./deployment/chart/ > k8s.yaml
    $ kubectl apply -n demo -f k8s.yaml

## Using

To access service inside of the local Kubernetes we need to forward the service port:

    $ kubectl -n demo port-forward svc/hello-k8s 4000:80

Then it can be used with `curl`:

    $ curl -H "Content-Type: application/json" -X POST -d "{\"name\": \"Joe\", \"age\": 35}" http://localhost:4000/persons
    $ curl -X GET http://localhost:4000/persons
    $ curl -X GET http://localhost:4000/persons/1
    $ curl -X DELETE http://localhost:4000/persons/1
