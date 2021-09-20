CREATE TABLE warehouses (
uniqueId SERIAL PRIMARY KEY,
districtId INTEGER REFERENCES districts(uniqueId),
address CHARACTER VARYING(255)
);