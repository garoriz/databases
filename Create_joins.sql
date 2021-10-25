-- узнать расположение складов по районам
SELECT warehouses.address, districts.name
FROM warehouses
JOIN districts ON districts.uniqueId = warehouses.districtId;

-- узнать место работы курьеров
SELECT couriers.name, couriers.pesonnelNumber, warehouses.address
FROM couriers
JOIN warehouses ON warehouses.uniqueId = couriers.warehouseId;

-- узнать каким транспортом пользуются курьеры и у кого его нет 
SELECT * FROM vehicles RIGHT JOIN couriers on vehicles.courierPersonnelNumber = couriers.pesonnelNumber;

-- узнать на каких складах какие менеджеры работают и увидеть склады, где не хватает менеджеров
SELECT * FROM warehouses LEFT JOIN managers on warehouses.uniqueId = managers.warehouseId;

-- увидеть пустующие склады и безработных курьеров, чтобы перевести этих курьеров в пустые склады
SELECT * FROM warehouses FULL JOIN couriers on warehouses.uniqueId = couriers.warehouseId;

-- увидеть кому доставляем товары, а также пользователей, которые ни разу не заказывали
SELECT * FROM orders FULL JOIN users on orders.deliveryAddress = users.address;

-- увидеть у каждого менеджера его босса
SELECT m.name Manager, b.name Boss
FROM managers m 
JOIN managers b ON b.uniqueId = m.parentId;

-- все занятые средства передвижения
SELECT v.numberOfVehicle, v.typeOfVehicle
FROM vehicles v 
WHERE EXISTS(SELECT 1 
	FROM couriers c 
	WHERE v.courierPersonnelNumber = c.personnelNumber);

-- все свободные средства передвижения	
SELECT v.numberOfVehicle, v.typeOfVehicle
FROM vehicles v 
WHERE NOT EXISTS(SELECT 1 
	FROM couriers c 
	WHERE v.courierPersonnelNumber = c.personnelNumber);