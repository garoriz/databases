CREATE TABLE order_product (
orderId INTEGER REFERENCES orders(uniqueId),
productId INTEGER REFERENCES products(uniqueId)
);