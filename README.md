# Hello World Environments
Template, "Hello World" environments, generates a full stack functional
project adhering (as closely as possible) to the SMART on FHIR (SoF)
protocol.

Intent combines a proof of concept with a functional demonstration of authentication, FHIR persistence and multiple SoF client types and interactions.

## Product Elements
- fEMR
  - [fEMR web service](https://github.com/uwcirg/cosri-patientsearch)
  - [HAPI FHIR](https://hapifhir.io/)
  - [JWTProxy](https://github.com/uwcirg/jwt-proxy)
  - [KeyCloak](https://www.keycloak.org/)
  - [PostgreSQL](https://postgrest.org/en/stable/)
  - [Redis](https://redis.io/)
- [Log Server](https://github.com/uwcirg/logserver)
- [Public SoF React Client](https://github.com/uwcirg/helloworld-react-client-sof)
- [Public SoF Vue Client](https://github.com/uwcirg/helloworld-vue-client-sof)

## Setup
Clone this repo to your desired location and follow Setup steps in [`dev`](./dev/README.md), to setup a development deploy.
