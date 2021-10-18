CREATE TABLE managers (
uniqueId SERIAL PRIMARY KEY,
warehouseId INTEGER REFERENCES warehouses(uniqueId),
name CHARACTER VARYING(255),
parentId INTEGER REFERENCES managers(uniqueId)
);

INSERT INTO managers VALUES 
(1, 1, 'Ivan', null),
(2, 1, 'Sher', 1),
(3, 1, 'Ilya', 2),
(4, 1, 'Vladimir', null);
