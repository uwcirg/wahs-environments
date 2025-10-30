---- keycloak ----
create database keycloak;


---- HAPI ----
create database hapifhir;


---- logserver ----
create database app_db;
\connect app_db;
create schema api;
create table api.events (
	id serial primary key,
	event jsonb not null
);

-- web user w/ read only auth
create role web_anon nologin;
grant usage on schema api to web_anon;
grant select on api.events to web_anon;

-- event logger role w/ write
create role event_logger nologin;
grant usage on schema api to event_logger;
grant all on api.events to event_logger;
grant usage, select on sequence api.events_id_seq to event_logger;
