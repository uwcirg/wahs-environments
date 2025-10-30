# Production Configuration
Sets up a production deploy of WAHS environments


## Setup
Copy the default env files:

    for file in *.default; do
        cp "$file" "${file%%.default}"
    done
Copy the `.env` file default:

    cp default.env .env

Modify the `.env` file as necessary. Lines that are not commented-out are required, commented lines are optional.


### Keycloak
#### Users
To delete the `test` user, click **Users** on the right menu, then click **View all users**. Click the **Delete** button in the row

## Deploy
To pull the latest configured docker images, and re-deploy services as necessary, run the following command:

    docker compose pull && docker compose up --detach
