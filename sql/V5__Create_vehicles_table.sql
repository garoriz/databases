CREATE TABLE vehicles (
numberOfVehicle SERIAL PRIMARY KEY,
courierPersonnelNumber INTEGER REFERENCES couriers(pesonnelNumber),
typeOfVehicle CHARACTER VARYING(255)
);