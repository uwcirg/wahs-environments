# Development Configuration
Sets up a development deploy of WAHS environments


## Setup
Copy the default env files:

    for file in *.default; do
        cp "$file" "${file%%.default}"
    done
Copy the `.env` file default:

    cp default.env .env

Modify the `.env` file as necessary. Lines that are not commented-out are required, commented lines are optional.


## Deploy
To pull the latest configured docker images, and re-deploy services as necessary, run the following command:

    docker compose pull && docker compose up --detach

### As a shl-creator development environment
To enable active reload while using this environment to develop the shl-creator frontend,
create a checkout of the [shl-ips repository](https://github.com/uwcirg/shl-ips) and set
the `SHL_CREATOR_CHECKOUT_DIR` variable in `.env` to the path of its root folder. No environment setup in the
checkout is necessary while developing there.
