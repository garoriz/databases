CREATE TABLE warehouse_product (
warehouseId INTEGER REFERENCES warehouses(uniqueId),
productId INTEGER REFERENCES products(uniqueId)
);