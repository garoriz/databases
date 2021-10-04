CREATE VIEW experienced_couriers
AS SELECT * FROM couriers
WHERE experienceInMonths > 12
WITH LOCAL CHECK OPTION;

CREATE VIEW few_products
AS SELECT * FROM products
WHERE count < 4
WITH LOCAL CHECK OPTION;