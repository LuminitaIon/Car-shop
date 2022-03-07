CREATE DATABASE carshop;
use carshop;

CREATE TABLE MESAJE
(
	MESAJ VARCHAR(300)
);

CREATE TABLE BRAND
(
	BRAND_CODE VARCHAR(10),
	BRAND_NAME VARCHAR(100) NOT NULL,
	PRIMARY KEY(BRAND_CODE)
);

CREATE TABLE COLOR
(
	COLOR_CODE integer,
	COLOR_NAME VARCHAR(30) NOT NULL,
	PRIMARY KEY(COLOR_CODE)
);

CREATE TABLE GEARBOX
(
	GEARBOX_CODE VARCHAR(10),
	GEARBOX_TYPE VARCHAR(50) NOT NULL,
	PRIMARY KEY(GEARBOX_CODE)
);

CREATE TABLE COMBUSTIBIL
(
	COMBUSTIBIL_ID integer,
	COMBUSTIBIL_TYPE VARCHAR(100) NOT NULL,
	PRIMARY KEY(COMBUSTIBIL_ID)
);

CREATE TABLE CAR_TYPE
(
	CAR_TYPE_ID integer,
	CAR_TYPE_NAME VARCHAR(50) NOT NULL,
	PRIMARY KEY(CAR_TYPE_ID)
);

CREATE TABLE CARS
(
	ID_CAR integer,
	MODEL_NAME VARCHAR(100) NOT NULL,
	BRAND_CODE VARCHAR(10) NOT NULL,
	car_year integer NOT NULL,
	COMBUSTIBIL_ID integer NOT NULL,
	CAR_TYPE_ID integer NOT NULL,
	price integer NOT NULL,
	GEARBOX_CODE VARCHAR(10) NOT NULL,
	NO_KM integer,
	ENGINE_POWER integer NOT NULL,
	COLOR_CODE integer NOT NULL,
	PRIMARY KEY(ID_CAR),
	FOREIGN KEY(BRAND_CODE) REFERENCES BRAND(BRAND_CODE),
	FOREIGN KEY(COMBUSTIBIL_ID) REFERENCES COMBUSTIBIL(COMBUSTIBIL_ID),
	FOREIGN KEY(CAR_TYPE_ID) REFERENCES CAR_TYPE(CAR_TYPE_ID),
	FOREIGN KEY(GEARBOX_CODE) REFERENCES GEARBOX(GEARBOX_CODE),
	FOREIGN KEY(COLOR_CODE) REFERENCES COLOR(COLOR_CODE)
);

DELIMITER $$

CREATE PROCEDURE add_brand(brand_code VARCHAR(10), brand_name VARCHAR(100))
BEGIN
	INSERT INTO BRAND (brand_code, brand_name) VALUES (brand_code, brand_name);
	COMMIT;
END $$

CREATE PROCEDURE delete_brand(b_code VARCHAR(10))
BEGIN
	DELETE FROM brand WHERE brand_code = b_code;
	COMMIT;
END $$

CREATE PROCEDURE select_brand(b_code VARCHAR(10))
BEGIN
	SELECT * FROM BRAND WHERE BRAND_CODE = b_code;
END $$

CREATE PROCEDURE select_all_brand()
BEGIN
	SELECT * FROM brand;
END $$

CREATE PROCEDURE add_color(color_code integer, color_name VARCHAR(100))
BEGIN
	INSERT INTO COLOR (color_code, color_name) VALUES (color_code, color_name);
	COMMIT;
END $$

CREATE PROCEDURE delete_color(c_code integer)
BEGIN
	DELETE FROM COLOR WHERE color_code = c_code;
	COMMIT;
END $$

CREATE PROCEDURE select_color(c_code integer)
BEGIN
	SELECT * FROM COLOR WHERE color_code = c_code;
END $$

CREATE PROCEDURE select_all_color()
BEGIN
	SELECT * FROM COLOR;
END $$

CREATE PROCEDURE add_gearbox(gearbox_code VARCHAR(10), gearbox_type VARCHAR(50))
BEGIN
	INSERT INTO GEARBOX(gearbox_code, gearbox_type) VALUES (gearbox_code, gearbox_type);
	COMMIT;
END $$

CREATE PROCEDURE delete_gearbox(gbx_code VARCHAR(10))
BEGIN
	DELETE FROM GEARBOX WHERE gearbox_code = gbx_code;
	COMMIT;
END;

CREATE PROCEDURE select_gearbox(gbx_code VARCHAR(10))
BEGIN
	SELECT * FROM GEARBOX WHERE gearbox_code = gbx_code;
END;

CREATE PROCEDURE select_all_gearbox()
BEGIN
	SELECT * FROM GEARBOX;
END $$

CREATE PROCEDURE add_combustibil(combustibil_id integer, combustibil_type VARCHAR(100))
BEGIN
	INSERT INTO COMBUSTIBIL(combustibil_id, combustibil_type) VALUES (combustibil_id, combustibil_type);
	COMMIT;
END $$

CREATE PROCEDURE delete_combustibil(cmb_id integer)
BEGIN
	DELETE FROM COMBUSTIBIL WHERE combustibil_id = cmb_id;
	COMMIT;
END;

CREATE PROCEDURE select_combustibil(cmb_id integer)
BEGIN
	SELECT * FROM COMBUSTIBIL WHERE combustibil_id = cmb_id;
END;

CREATE PROCEDURE select_all_combustibil()
BEGIN
	SELECT * FROM COMBUSTIBIL;
END $$

CREATE PROCEDURE add_car_type(car_type_id integer, car_type_name VARCHAR(50))
BEGIN
	INSERT INTO CAR_TYPE(car_type_id, car_type_name) VALUES (car_type_id, car_type_name);
	COMMIT;
END $$

CREATE PROCEDURE delete_car_type(ct_id integer)
BEGIN
	DELETE FROM CAR_TYPE WHERE car_type_id = ct_id;
	COMMIT;
END;

CREATE PROCEDURE select_car_type(ct_id integer)
BEGIN
	SELECT * FROM CAR_TYPE WHERE car_type_id = ct_id;
END;

CREATE PROCEDURE select_all_car_type()
BEGIN
	SELECT * FROM CAR_TYPE;
END $$

CREATE PROCEDURE add_car(id_car integer, model_name VARCHAR(100), brand_code VARCHAR(10), 
						car_year integer, combustibil_id integer, car_type_id integer, 
						price integer, gearbox_code VARCHAR(10), no_km integer, 
						engine_power integer, color_code integer)
BEGIN
	INSERT INTO CARS(id_car, model_name, brand_code, car_year, combustibil_id, car_type_id, 
					price, gearbox_code, no_km, engine_power, color_code) 
	VALUES (id_car, model_name, brand_code, car_year, combustibil_id, car_type_id, price, 
			gearbox_code, no_km, engine_power, color_code);
	COMMIT;
END $$

CREATE PROCEDURE delete_car(id_c integer)
BEGIN
	DELETE FROM CARS WHERE id_car = id_c;
	COMMIT;
END;

CREATE PROCEDURE select_all_by_id(id_c integer)
BEGIN
	SELECT id_car, model_name, car_year, price
	FROM CARS
	WHERE CARS.id_car = id_c;
END;

CREATE PROCEDURE select_all_by_comb_id(comb_id integer)
BEGIN
	SELECT id_car, model_name, car_year, combustibil_id
	FROM CARS
	WHERE CARS.combustibil_id = comb_id;
END;
-- call select_all_by_comb_id(0);
CREATE PROCEDURE select_all_by_car_type_id(ct_id integer)
BEGIN
	SELECT id_car, model_name, car_year, car_type_id
	FROM CARS
	WHERE CARS.car_type_id = ct_id;
END;

CREATE PROCEDURE select_all_by_gearbox_code(gbx_code VARCHAR(10))
BEGIN
	SELECT id_car, model_name, car_year, price
	FROM CARS
	WHERE CARS.gearbox_code = gbx_code;
END;

CREATE PROCEDURE select_all_by_color(color_c integer)
BEGIN
	SELECT id_car, model_name, car_year, price
	FROM CARS
	WHERE CARS.color_code = color_c;
END;

CREATE PROCEDURE select_all_cars()
BEGIN
	SELECT * FROM CARS;
END $$
call select_all_cars();
CREATE FUNCTION get_car_gearbox(c_id int) RETURNS varchar(20) DETERMINISTIC
BEGIN
    DECLARE t varchar(15);
    SELECT gearbox_type INTO t
	FROM CARS, GEARBOX
	WHERE CARS.id_car = c_id
	AND
	CARS.gearbox_code = GEARBOX.gearbox_code;
	
	RETURN t;
END;
-- select get_car_gearbox(2);
CREATE FUNCTION clasify_by_power(power int) returns varchar(30) deterministic
BEGIN
	DECLARE status_car varchar(20) DEFAULT "";
    IF power < 100 THEN 
        SET status_car = "Normal"; 
    ELSEIF power > 100 AND power < 400 THEN
        SET status_car = "Sport";

    ELSE
        SET status_car = "Passion";
    END IF;

	RETURN status_car;
END $$

CREATE TRIGGER tgr_cars AFTER INSERT ON cars for each ROW
BEGIN 
	DECLARE model VARCHAR(100);
    DECLARE pret integer;
	SELECT MODEL_NAME INTO model
	FROM cars
	WHERE id_car = NEW.id_car;

	SELECT price INTO pret
	FROM cars
	WHERE id_car = NEW.id_car;

	INSERT INTO mesaje(MESAJ) VALUES(concat('S-a adaugat modelul', model, 'cu pretul: ', pret));
END;

-- popularea tabelelor

INSERT INTO gearbox(GEARBOX_CODE, GEARBOX_TYPE) VALUES ("auto", "automata");
INSERT INTO gearbox(GEARBOX_CODE, GEARBOX_TYPE) VALUES ("man", "manuala");
INSERT INTO car_type(car_type_id, car_type_name) VALUES (10, "Sedan");
INSERT INTO car_type(car_type_id, car_type_name) VALUES (11, "Break");
INSERT INTO car_type(car_type_id, car_type_name) VALUES (12, "SUV");
INSERT INTO car_type(car_type_id, car_type_name) VALUES (13, "Pickup");
INSERT INTO car_type(car_type_id, car_type_name) VALUES (14, "Truck");

INSERT INTO combustibil(combustibil_id, combustibil_type) VALUES (0, "Motorina");
INSERT INTO combustibil(combustibil_id, combustibil_type) VALUES (1, "Benzina");
INSERT INTO combustibil(combustibil_id, combustibil_type) VALUES (2, "Gaz");
INSERT INTO combustibil(combustibil_id, combustibil_type) VALUES (3, "Electric");
INSERT INTO combustibil(combustibil_id, combustibil_type) VALUES (4, "Hibrid");

INSERT INTO color(color_code, color_name) VALUES (0, "rosu");
INSERT INTO color(color_code, color_name) VALUES (1, "negru");
INSERT INTO color(color_code, color_name) VALUES (2, "gri");
INSERT INTO color(color_code, color_name) VALUES (3, "alb");
INSERT INTO color(color_code, color_name) VALUES (4, "albastru");

INSERT INTO brand(brand_code, brand_name) VALUES("MZD", "Mazda");
INSERT INTO brand(brand_code, brand_name) VALUES("RNT", "Renault");
INSERT INTO brand(brand_code, brand_name) VALUES("AD", "Audi");
INSERT INTO brand(brand_code, brand_name) VALUES("BMW", "Bavarian Motor Works");
INSERT INTO brand(brand_code, brand_name) VALUES("TSL", "Tesla");
INSERT INTO brand(brand_code, brand_name) VALUES("MB", "Mercedes-Benz");
INSERT INTO brand(brand_code, brand_name) VALUES("TYT", "Toyota");

INSERT INTO cars(id_car, model_name, brand_code, car_year, combustibil_id, car_type_id, price, gearbox_code, no_km, engine_power, color_code) 
VALUES(1, "Mazda 6", "MZD", 2009, 1, 10, 4990, "man", 173000, 90, 0);
INSERT INTO cars(id_car, model_name, brand_code, car_year, combustibil_id, car_type_id, price, gearbox_code, no_km, engine_power, color_code)
VALUES(2, "Renault Clio", "RNT", 2018, 2, 10, 13480, "man", 990, 100, 1);
INSERT INTO cars(id_car, model_name, brand_code, car_year, combustibil_id, car_type_id, price, gearbox_code, no_km, engine_power, color_code)
VALUES(3, "Audi Q7", "AD", 2021, 0, 13, 19980, "auto", 234492, 250, 4);
INSERT INTO cars(id_car, model_name, brand_code, car_year, combustibil_id, car_type_id, price, gearbox_code, no_km, engine_power, color_code)
VALUES(4, "BMW Seria 1", "BMW", 2012, 1, 11, 7990, "man", 180000, 136, 2);
INSERT INTO cars(id_car, model_name, brand_code, car_year, combustibil_id, car_type_id, price, gearbox_code, no_km, engine_power, color_code)
VALUES(5, "Tesla Model Y", "TSL", 2020, 3, 12, 66989, "auto", 50, 346, 3);
INSERT INTO cars(id_car, model_name, brand_code, car_year, combustibil_id, car_type_id, price, gearbox_code, no_km, engine_power, color_code)
VALUES(6, "Mercedes-Benz Atego", "MB", 2017, 0, 14, 38500, "man", 83940, 115, 3);
INSERT INTO cars(id_car, model_name, brand_code, car_year, combustibil_id, car_type_id, price, gearbox_code, no_km, engine_power, color_code)
VALUES(7, "Toyota C-HR", "TYT", 2020, 4, 12, 29500, "auto", 1, 98, 2);
INSERT INTO cars(id_car, model_name, brand_code, car_year, combustibil_id, car_type_id, price, gearbox_code, no_km, engine_power, color_code)
VALUES(8, "Toyota Corolla", "TYT", 2019, 1, 10, 21900, "man", 15, 123, 0);
INSERT INTO cars(id_car, model_name, brand_code, car_year, combustibil_id, car_type_id, price, gearbox_code, no_km, engine_power, color_code)
VALUES(9, "Audi A4", "AD", 2018, 1, 11, 17190, "auto", 214872, 150, 1);
INSERT INTO cars(id_car, model_name, brand_code, car_year, combustibil_id, car_type_id, price, gearbox_code, no_km, engine_power, color_code)
VALUES(10,"Mercedes-Benz GLC", "MB", 2022, 1, 12, 58407, "auto", 1, 450, 4);