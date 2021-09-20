CREATE TABLE districts (
uniqueId SERIAL PRIMARY KEY,
cityId INTEGER REFERENCES cities(uniqueId),
name CHARACTER VARYING(255)
);