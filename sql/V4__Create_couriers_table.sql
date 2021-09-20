CREATE TABLE couriers (
pesonnelNumber SERIAL PRIMARY KEY,
warehouseId INTEGER REFERENCES warehouses(uniqueId),
name CHARACTER VARYING(255),
experienceInMonths INT
);