--название города не может быть null
ALTER TABLE cities ALTER COLUMN name SET NOT NULL;

--название района не может быть null
ALTER TABLE districts ALTER COLUMN name SET NOT NULL;

--название склада не может быть null
ALTER TABLE warehouses ALTER COLUMN address SET NOT NULL;

--количество отработанных месяцев не может быть отрицательным
ALTER TABLE couriers ADD CONSTRAINT positive_experience_in_months CHECK (experienceInMonths > -1);

--тип транспорта не может быть null
ALTER TABLE vehicles ALTER COLUMN typeOfVehicle SET NOT NULL;

--количество продуктов не может быть отрицательным
ALTER TABLE products ADD CONSTRAINT positive_count CHECK (count > -1);

--количество продуктов не может быть отрицательным
ALTER TABLE orders ADD CONSTRAINT positive_count CHECK (countOfProducts > -1);

--имя пользователя не может быть null
ALTER TABLE users ALTER COLUMN name SET NOT NULL;

--имя менеджера не может быть null
ALTER TABLE managers ALTER COLUMN name SET NOT NULL;

CREATE MATERIALIZED VIEW users_from_moskovskaya
AS SELECT * FROM users WHERE address = 'Moskovskaya'; 

CREATE MATERIALIZED VIEW bykes
AS SELECT * FROM vehicles WHERE typeOfVehicle = 'byke';