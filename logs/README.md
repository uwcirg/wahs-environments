# Logserver

Sets up a central location to store and view logs


## Setup

Copy the .env file default:

    cp default.env .env

Modify each newly copied env file as necessary. Lines that are not commented-out are required, commented lines are optional.


Initialize the logserver submodule defined in the root directory's .gitmodules file:

    git submodule init

To update the submodule, run

    git submodule update
