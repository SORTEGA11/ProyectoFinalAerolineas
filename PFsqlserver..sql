USE LineasAereasRusas
SELECT* FROM ticket_flights

DROP TABLE IF EXISTS ticket_flights
CREATE TABLE dbo.ticket_flights (
    ticket_no VARCHAR(13),
    flight_id INT,
    fare_conditions VARCHAR(20),
    amount DECIMAL(10, 2)
);

BULK INSERT dbo.ticket_flights
FROM 'C:\Users\ISAAC\Desktop\Data Analyst\ticket_flights.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

-- Verificamos que los datos se hayan insertado correctamente
SELECT TOP 20 * FROM dbo.ticket_flights;
-- Creacion PK tabla seats
SELECT * FROM seats

ALTER TABLE seats
ADD seat_id NVARCHAR(255);

UPDATE seats
SET seat_id = CAST(aircraft_code AS NVARCHAR(10)) + '-' + seat_no;

SELECT seat_id, COUNT(*)
FROM seats
GROUP BY seat_id
HAVING COUNT(*) > 1;

-- Creamos la regla seat_id is not null y la PK
ALTER TABLE seats
ALTER COLUMN seat_id NVARCHAR(255) NOT NULL;

ALTER TABLE seats
ADD CONSTRAINT PK_seat_id PRIMARY KEY (seat_id);

-- Añadimos PK a la tabla boarfing_passes

SELECT * FROM boarding_passes

ALTER TABLE boarding_passes
ADD boarding_passes_id INT IDENTITY(1,1) PRIMARY KEY;

-- Creamos la Pk para la tabla ticket_flights

SELECT* FROM ticket_flights

select * from seats

ALTER TABLE seats
ADD seat_id NVARCHAR(255);

UPDATE seats
SET seat_id = CAST(aircraft_code AS NVARCHAR(10)) + '-' + seat_no;

SELECT seat_id, COUNT(*)
FROM seats
GROUP BY seat_id
HAVING COUNT(*) > 1;

SELECT *
FROM seats
WHERE seat_id IS NULL

ALTER TABLE seats
ALTER COLUMN seat_id NVARCHAR(255) NOT NULL;

ALTER TABLE seats
ADD CONSTRAINT PK_seat_id PRIMARY KEY (seat_id);


SELECT * FROM boarding_passes

ALTER TABLE boarding_passes
ADD boarding_passes_id INT IDENTITY(1,1) PRIMARY KEY;

-- Creamos la PK para la tabla ticket_flights
SELECT* FROM ticket_flights

ALTER TABLE ticket_flights
ADD ticket_flight_id VARCHAR(100);

UPDATE ticket_flights
SET ticket_flight_id = CONCAT(ticket_no, '-', flight_id);

SELECT ticket_flight_id, COUNT(*)
FROM ticket_flights
GROUP BY ticket_flight_id
HAVING COUNT(*) > 1;


ALTER TABLE ticket_flights
ALTER COLUMN ticket_flight_id NVARCHAR(100) NOT NULL;

ALTER TABLE ticket_flights
ADD CONSTRAINT PK_ticket_flight_id PRIMARY KEY (ticket_flight_id);

-- Creamos la PK de la tabla bookings

SELECT* FROM bookings;

ALTER TABLE bookings
ALTER COLUMN book_ref NVARCHAR(50) NOT NULL; 

ALTER TABLE bookings
ADD CONSTRAINT PK_book_ref PRIMARY KEY (book_ref);

-- Creamos la PK para la tabla de flights

SELECT* FROM flights;

ALTER TABLE flights
ALTER COLUMN flight_id NVARCHAR(50) NOT NULL; 

ALTER TABLE flights
ADD CONSTRAINT PK_flight_id PRIMARY KEY (flight_id); 

/* Creamos el modelo relacional de la base de datos, las claves foraneas respectivas
y finalizamos el modelo de la base de datos*/

-- Relación tickets - bookings 
ALTER TABLE tickets 
ADD CONSTRAINT FK_tickets_book_ref FOREIGN KEY (book_ref) REFERENCES bookings (book_ref);

ALTER TABLE tickets
ALTER COLUMN book_ref nvarchar(50);

-- Relación tickets - ticket_flights

ALTER TABLE ticket_flights 
ADD CONSTRAINT FK_ticket_flights_ticket_no FOREIGN KEY (ticket_no) REFERENCES tickets (ticket_no);

ALTER TABLE ticket_flights
ALTER COLUMN ticket_no varchar(50);

ALTER TABLE tickets
ALTER COLUMN ticket_no VARCHAR(50) NOT NULL;

ALTER TABLE tickets
ADD CONSTRAINT PK_tickets PRIMARY KEY (ticket_no);

-- Relación ticket_flights-flights

ALTER TABLE ticket_flights
ADD CONSTRAINT FK_ticket_flights_flights FOREIGN KEY (flight_id) REFERENCES flights(flight_id);

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'flights' AND COLUMN_NAME = 'flight_id';

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ticket_flights' AND COLUMN_NAME = 'flight_id';

ALTER TABLE ticket_flights
ALTER COLUMN flight_id NVARCHAR(50);

-- Relación tabla aircraft_data con flights

ALTER TABLE flights
ADD CONSTRAINT FK_flights_aircrafts_data FOREIGN KEY (aircraft_code) REFERENCES aircrafts_data(aircraft_code);

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'flights' AND COLUMN_NAME = 'aircraft_code';

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'aircrafts_data' AND COLUMN_NAME = 'aircraft_code';

ALTER TABLE flights
ALTER COLUMN aircraft_code VARCHAR(20); 

-- Relación tabla aircrafts_data con seats

ALTER TABLE seats
ADD CONSTRAINT FK_seats_aircraft_code FOREIGN KEY (aircraft_code) REFERENCES aircrafts_data(aircraft_code);

ALTER TABLE seats
ALTER COLUMN aircraft_code VARCHAR(20);

-- Relacion tickets con boarding passes

ALTER TABLE boarding_passes
ADD CONSTRAINT FK_boarding_passes_ticket_no FOREIGN KEY (ticket_no) REFERENCES tickets(ticket_no);

ALTER TABLE boarding_passes
ALTER COLUMN ticket_no VARCHAR(50);

-- Relacion boarding_passes con flights

ALTER TABLE boarding_passes
ADD CONSTRAINT FK_boarding_passes_flight_id FOREIGN KEY (flight_id) REFERENCES flights(flight_id);

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'flights' AND COLUMN_NAME = 'flight_id';

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'boarding_passes' AND COLUMN_NAME = 'flight_id';

ALTER TABLE boarding_passes
ALTER COLUMN flight_id	NVARCHAR(50); 

-- Relación entre flights y aiports_data

ALTER TABLE flights
ADD CONSTRAINT fk_departure_airport FOREIGN KEY (departure_airport) REFERENCES airports_data(airport_code);

ALTER TABLE flights
ADD CONSTRAINT fk_arrival_airport FOREIGN KEY (arrival_airport) REFERENCES airports_data(airport_code);

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'flights' AND COLUMN_NAME = 'departure_airport';

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'airports_data' AND COLUMN_NAME = 'airport_code';

ALTER TABLE flights
ALTER COLUMN departure_airport VARCHAR(3);

ALTER TABLE flights
ALTER COLUMN arrival_airport VARCHAR(3);






