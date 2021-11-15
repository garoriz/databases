--создание таблиц
create table airport (
id SERIAL PRIMARY KEY,
name CHARACTER VARYING(30) NOT NULL,
location CHARACTER VARYING(30)
);

create table plane (
id SERIAL PRIMARY KEY,
company CHARACTER VARYING(30),
number CHARACTER VARYING(30),
type_plane CHARACTER VARYING(30) NOT NULL,
capacity INTEGER NOT NULL,
lifetime_in_years INTEGER NOT NULL
);

create table passenger (
id SERIAL PRIMARY KEY,
fio CHARACTER VARYING(100) NOT NULL
);

create table crew (
id SERIAL PRIMARY KEY,
fio_pilot1 CHARACTER VARYING(30),
fio_pilot2 CHARACTER VARYING(30),
fio_stewardess1 CHARACTER VARYING(30),
fio_stewardess2 CHARACTER VARYING(30),
fio_stewardess3 CHARACTER VARYING(30),
fio_technician CHARACTER VARYING(30)
);

create table flight (
id SERIAL PRIMARY KEY,
from_airport INTEGER REFERENCES airport(id), 
to_airport INTEGER REFERENCES airport(id), 
id_plane INTEGER REFERENCES plane(id),
id_crew INTEGER REFERENCES crew(id),
duration_in_hours INTEGER NOT NULL,
count_of_passengers INTEGER NOT NULL,
date_flight TIMESTAMP NOT NULL
);

create table passenger_flight (
passenger_id INTEGER REFERENCES passenger(id),
flight_id INTEGER REFERENCES flight(id)
);

--добавление сущностей
INSERT INTO airport VALUES 
(1, 'a1', 'Kazan'),
(2, 'a2', 'Berlin'),
(3, 'a3', 'Brazilia');

INSERT INTO plane VALUES 
(1, 'c1', '123', 'Simple', 100, 5),
(2, 'c2', '45S6', 'Simple', 50, 0),
(3, 'c3', '789A', 'Fast', 30, 2);

INSERT INTO crew VALUES 
(1, 'Ivan', 'Ruslan', 'Maria', 'Maria', 'Maria', 'Pavel'),
(2, 'Aleksandr', 'Albert', 'Anstasia', 'Anstasia', 'Anstasia', 'Nikita');

INSERT INTO flight VALUES 
(1, 1, 2, 1, 1, 5, 23, '1999-01-08'),
(2, 2, 3, 1, 1, 10, 71, '2000-02-09'),
(3, 3, 1, 1, 1, 40, 63, '2001-03-10'),
(4, 1, 3, 1, 1, 15, 23, '2002-04-11'),
(5, 3, 1, 1, 1, 11, 17, '2003-05-12'),
(6, 3, 1, 2, 2, 20, 31, '2004-06-13'),
(7, 1, 2, 2, 2, 21, 8, '2005-07-14'),
(8, 2, 3, 2, 2, 1, 10, '2006-08-15'),
(9, 3, 1, 2, 2, 8, 41, '2007-09-16'),
(10, 1, 3, 2, 2, 20, 11, '2008-10-18');

INSERT INTO passenger VALUES 
(1, 'Ivan'),
(2, 'Ivan2');

INSERT INTO passenger_flight VALUES 
(1, 1),
(1, 2),
(2, 3);

--самый длинный рейс
SELECT * FROM flight
    WHERE duration_in_hours = (SELECT max(duration_in_hours) FROM flight);
	
-- количество рейсов для каждого аэропорта за указанный день
SELECT airport.id, airport.name, location, COUNT(airport.id) FROM airport 
JOIN flight ON flight.from_airport = airport.id OR flight.to_airport = airport.id 
WHERE date_flight = '1999-01-08'
GROUP BY airport.id;

-- ФИО пассажира, который провел в полетах наибольшее количество часов и наименьшее
CREATE VIEW view_flight_passenger
AS SELECT * FROM flight
JOIN passenger_flight ON passenger_flight.flight_id = flight.id;

WITH max_duration AS (
SELECT passenger.fio, SUM(vfp.duration_in_hours) FROM view_flight_passenger AS vfp
JOIN passenger ON vfp.passenger_id = passenger.id
GROUP BY passenger.id
)
SELECT * FROM max_duration
WHERE sum = (SELECT max(sum) FROM max_duration);

WITH min_duration AS (
SELECT passenger.fio, SUM(vfp.duration_in_hours) FROM view_flight_passenger AS vfp
JOIN passenger ON vfp.passenger_id = passenger.id
GROUP BY passenger.id
)
SELECT * FROM min_duration
WHERE sum = (SELECT min(sum) FROM min_duration);

--Для каждого пилота вывести цепчку городов, по которым он летал
--объединение пилотов 1 с рейсами 
CREATE VIEW pilot_flight
AS SELECT fio_pilot1, flight.* FROM crew
JOIN flight ON crew.id = flight.id_crew;

--объединение пилотов 2 с рейсами
CREATE VIEW pilot_flight2
AS SELECT fio_pilot2, flight.* FROM crew
JOIN flight ON crew.id = flight.id_crew;

--объединение всех пилотов со всеми рейсами, в которых они принимали участие 
CREATE VIEW pilot_flight_all
AS select * from pilot_flight union select * from pilot_flight2;

--добавление к view столбца 'город отправления'
CREATE VIEW from_city
AS SELECT pilot_flight_all.*, airport.location AS from_city FROM pilot_flight_all
JOIN airport ON pilot_flight_all.from_airport = airport.id;

--добавление к view столбца 'город назначения'
CREATE VIEW from_city_to_city
AS SELECT from_city.*, airport.location AS to_city FROM from_city
JOIN airport ON from_city.to_airport = airport.id
ORDER BY date_flight;

CREATE VIEW way
AS SELECT fio_pilot1, string_agg(from_city, '-') AS way FROM from_city_to_city
GROUP BY fio_pilot1, id_crew;