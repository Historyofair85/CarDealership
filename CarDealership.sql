CREATE TABLE salesperson(
	employee_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	department VARCHAR(25) NOT NULL
);

CREATE TABLE cars(
	car_id SERIAL PRIMARY KEY,
	serial_number INTEGER NOT NULL,
	make VARCHAR NOT NULL,
	model VARCHAR NOT NULL,
	"year" INTEGER NOT NULL,
	color VARCHAR NOT NULL,
	status VARCHAR NOT NULL,
	car_price NUMERIC(8,2),
	employee_id INTEGER NOT NULL,
	FOREIGN KEY(employee_id) REFERENCES salesperson(employee_id)
);

CREATE TABLE invoice(
	invoice_id SERIAL PRIMARY KEY,
	purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	sale_car_id INTEGER NOT NULL,
	FOREIGN KEY(car_id) REFERENCES cars(car_id),
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	employee_id INTEGER NOT NULL,
	FOREIGN KEY(employee_id) REFERENCES salesperson(employee_id)
);

CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(25) NOT NULL,
	phone_number VARCHAR(15),
	email VARCHAR(50)
);

CREATE TABLE service(
	service_car_id SERIAL PRIMARY KEY,
	serial_number VARCHAR NOT NULL,
	make VARCHAR NOT NULL,
	model VARCHAR NOT NULL,
	"year" INTEGER NOT NULL,
	color VARCHAR NOT NULL,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE service_ticket(
	ticket_id SERIAL PRIMARY KEY,
	service_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	employee_id INTEGER NOT NULL,
	FOREIGN KEY(employee_id) REFERENCES employee(employee_id),
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	service_car_id INTEGER NOT NULL,
	FOREIGN KEY(service_car_id) REFERENCES car_for_service(service_car_id)
);

CREATE TABLE service_record(
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	ticket_id INTEGER NOT NULL,
	FOREIGN KEY(ticket_id) REFERENCES service_ticket(ticket_id),
	employee_id INTEGER NOT NULL,
	FOREIGN key(employee_id) REFERENCES salesperson(employee_id),
	service_car_id INTEGER NOT NULL,
	FOREIGN KEY(service_car_id) REFERENCES service(service_car_id) 
);

-- Inserts the employee information to the employee table
INSERT INTO employee(
	first_name,
	last_name,
	department 
)VALUES (
	'Tony',
	'Stark',
	'Sales'
);

INSERT INTO employee(
	first_name,
	last_name,
	department 
)VALUES (
	'Steve',
	'Rodgers',
	'Sales'
);

--Customer Procedure
CREATE OR REPLACE PROCEDURE add_customer(
	first_name VARCHAR, 
	last_name VARCHAR, 
	phone_number VARCHAR(15), 
	email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO customer(first_name, last_name, phone_number, email)
	values(first_name, last_name, phone_number, email);
END;
$$;

-- Add Customer
CALL add_customer('Sue', 'Storm', '(215) 783-6681', 'MsFantastic@fantasticfour.com');

CALL add_customer('Reed', 'Richards', '(215) 216-8084', 'MrFantastic@fantasticfour.com' );

SELECT *
FROM customer 

-- cars procedure
CREATE OR REPLACE PROCEDURE add_car_sale(
	serial_number VARCHAR,	
	make VARCHAR,
	model VARCHAR,
	"year" INTEGER,
	color VARCHAR,
	status VARCHAR,
	car_price NUMERIC(8,2)
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO cars(serial_number, make, model, "year", color, status, car_price)
	VALUES(serial_number, make, model, "year", color, status, car_price);
END;
$$;

--Cars information
CALL add_cars('EUD850933U', 'Stark', 'HeliJET', 2012, 'Silver', 'SOLD', 100,000);
CALL add_cars('LEB316749B', 'AVENGERS', 'QuinJET', 2012, 'Black', 'AVAILABLE', 500,000);
CALL add_cars('DNW884503Y', 'WayneTECH', 'Tumbler', 2008, 'Black', 'AVAILABLE', 1,000,000); 
CALL add_cars('NMN573903C', 'Xavier', 'BlackBird', 1985, 'Blue', 'SOLD', 1,500,000);
CALL add_cars('WPL103284P', 'WayneTECh', 'BATcycle', 208, 'Black', 'AVAILABLE', 250,000);
CALL add_cars('CSR678230K', 'OSCORP', 'GoblinFlyer', 2004, 'Green', 'SOLD', 300,000);

SELECT *
FROM cars;

