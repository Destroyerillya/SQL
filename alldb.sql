REVOKE CONNECT ON DATABASE mydatabase FROM public;

SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'mydatabase';

DROP DATABASE IF EXISTS mydatabase;
CREATE DATABASE mydatabase;
\connect mydatabase;

DROP TABLE IF EXISTS Ships_voyage;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Ship_declaration;
DROP TABLE IF EXISTS Table_of_ports;
DROP TABLE IF EXISTS Price_between_2_ports_FREIGHT;
DROP TABLE IF EXISTS Price_between_2_ports_PASSENGER;
DROP TABLE IF EXISTS Cabin_class;
DROP TABLE IF EXISTS Type_of_cargo;
DROP TABLE IF EXISTS Freight;
DROP TABLE IF EXISTS Passenger;
DROP TABLE IF EXISTS Capitan;
DROP TABLE IF EXISTS Ship;
DROP TABLE IF EXISTS Port;
DROP TABLE IF EXISTS Voyage;
DROP TABLE IF EXISTS Client;

CREATE TABLE Capitan(
    ID_Capitan INT NOT NULL PRIMARY KEY CHECK(ID_Capitan > 0) UNIQUE,
    First_name VARCHAR(16) NOT NULL CHECK (First_name SIMILAR TO '[A-Z][a-z]+'),
    Second_name VARCHAR(16) NOT NULL CHECK (Second_name SIMILAR TO '[A-Z][a-z]+'),
    Third_name VARCHAR(16) NOT NULL CHECK (Third_name SIMILAR TO '[A-Z][a-z]+'),
    Passport_ID VARCHAR(20) NOT NULL UNIQUE,
    Years_of_experience INT NOT NULL CHECK(Years_of_experience > 0),
    Permission_to_operate_ships BOOLEAN NOT NULL
);

CREATE TABLE Ship(
    Number_of_ship INT NOT NULL CHECK(Number_of_ship > 0) UNIQUE,
    Serial_of_ship VARCHAR(2) NOT NULL CHECK (Serial_of_ship SIMILAR TO 'FR' OR Serial_of_ship SIMILAR TO 'PA'),
    Name_of_ship VARCHAR(20) NOT NULL CHECK (Name_of_ship SIMILAR TO '[A-Z][a-z]+') UNIQUE,
    Year_of_issue DATE NOT NULL,
    Cost_of_annual_maintenance INT NOT NULL CHECK(Cost_of_annual_maintenance > 0),
    Act_of_cancellation INT NULL CHECK(Act_of_cancellation > 0) UNIQUE,
    Status_of_ship VARCHAR(20) NOT NULL CHECK(Status_of_ship SIMILAR TO '[A-Z]([a-z]|[ \f\n\r\t\v])+'),
    ABC_Analysis CHAR(1) NOT NULL CHECK(ABC_Analysis SIMILAR TO 'A' OR ABC_Analysis SIMILAR TO 'B' OR ABC_Analysis SIMILAR TO 'C'),
    PRIMARY KEY (Number_of_ship,Serial_of_ship)
);

CREATE TABLE Port(
    Name_of_port VARCHAR(20) NOT NULL PRIMARY KEY CHECK(Name_of_port SIMILAR TO '[A-Z][a-z]+') UNIQUE,
    Country VARCHAR(20) NOT NULL CHECK(Country SIMILAR TO '[A-Z][a-z]+'),
    City VARCHAR(20) NOT NULL CHECK(City SIMILAR TO '[A-Z][A-z]+'),
    X FLOAT NOT NULL,
    Y FLOAT NOT NULL,
    Cost_of_stay_in_port MONEY NOT NULL,
    Ship_unloading_cost MONEY NOT NULL
);

CREATE TABLE Voyage(
    Voyage_number INT NOT NULL PRIMARY KEY CHECK(Voyage_number > 0) UNIQUE,
    Departure_date TIMESTAMP NOT NULL,
    Arrival_date TIMESTAMP NOT NULL,
    Total_distance FLOAT NOT NULL CHECK(Total_distance > 0),
    Passed_passengers INT NULL CHECK(Passed_passengers > -1),
    Risen_passengers INT NULL CHECK(Risen_passengers > -1),
    Unloaded_tone FLOAT NULL CHECK(Unloaded_tone > -1),
    Loaded_tone FLOAT NULL CHECK(Loaded_tone > -1)
);

CREATE TABLE Client(
    ID_Client INT NOT NULL PRIMARY KEY CHECK(ID_Client > 0) UNIQUE ,
    First_name VARCHAR(16) NOT NULL CHECK (First_name SIMILAR TO '[A-Z][a-z]+'),
    Second_name VARCHAR(16) NOT NULL CHECK (Second_name SIMILAR TO '[A-Z][a-z]+'),
    Third_name VARCHAR(16) NOT NULL CHECK (Third_name SIMILAR TO '[A-Z][a-z]+'),
    Passport_ID VARCHAR(20) NOT NULL UNIQUE,
    Photograph BYTEA NOT NULL,
    Customers_internal_account VARCHAR(20) NOT NULL UNIQUE,
    Balance MONEY NOT NULL,
    Average_annual_consumption MONEY NOT NULL
);

CREATE TABLE Freight(
    Number_of_ship INT NOT NULL,
    Serial_of_ship VARCHAR(2) NOT NULL CHECK (Serial_of_ship SIMILAR TO 'FR'),
    Tonnage_of_ship INT NOT NULL,
    FOREIGN KEY (Number_of_ship,Serial_of_ship) references Ship,
    PRIMARY KEY (Number_of_ship,Serial_of_ship)
);

CREATE TABLE Passenger(
    Number_of_ship INT NOT NULL,
    Serial_of_ship VARCHAR(2) NOT NULL CHECK (Serial_of_ship SIMILAR TO 'PA'),
    Number_of_cabins INT NOT NULL,
    FOREIGN KEY (Number_of_ship,Serial_of_ship) references Ship,
    PRIMARY KEY (Number_of_ship,Serial_of_ship)
);

CREATE TABLE Cabin_class(
    Cabin_of_class VARCHAR(20) NOT NULL,
    Number_of_ship INT NOT NULL,
    Serial_of_ship VARCHAR(2) NOT NULL CHECK (Serial_of_ship SIMILAR TO 'PA'),
    Number_of_places INT NOT NULL,
    Cost_of_cabin MONEY NOT NULL,
    FOREIGN KEY (Number_of_ship,Serial_of_ship) references Passenger,
    PRIMARY KEY (Cabin_of_class,Number_of_ship,Serial_of_ship)
);

CREATE TABLE Type_of_cargo(
    Name_of_cargo VARCHAR(20) NOT NULL,
    Number_of_ship INT NOT NULL,
    Serial_of_ship VARCHAR(2) NOT NULL CHECK (Serial_of_ship SIMILAR TO 'FR'),
    Number_of_goods INT NOT NULL,
    Cost_of_cargo MONEY NOT NULL,
    FOREIGN KEY (Number_of_ship,Serial_of_ship) references Freight,
    PRIMARY KEY (Name_of_cargo,Number_of_ship,Serial_of_ship)
);

CREATE TABLE Price_between_2_ports_FREIGHT(
    Name_of_cargo VARCHAR(20) NOT NULL,
    Arrival_port VARCHAR(20) NOT NULL REFERENCES Port,
    Depart_port VARCHAR(20) NOT NULL REFERENCES Port,
    Number_of_ship INT NOT NULL,
    Serial_of_ship VARCHAR(2) NOT NULL CHECK (Serial_of_ship SIMILAR TO 'FR'),
    Total_cost_of_cargo MONEY NOT NULL,
    FOREIGN KEY (Name_of_cargo,Number_of_ship,Serial_of_ship) references Type_of_cargo,
    PRIMARY KEY (Name_of_cargo,Number_of_ship,Serial_of_ship)
);

CREATE TABLE Price_between_2_ports_PASSENGER(
    Class_of_cabin VARCHAR(20) NOT NULL,
    Arrival_port VARCHAR(20) NOT NULL REFERENCES Port,
    Depart_port VARCHAR(20) NOT NULL REFERENCES Port,
    Number_of_ship INT NOT NULL,
    Serial_of_ship VARCHAR(2) NOT NULL CHECK (Serial_of_ship SIMILAR TO 'PA'),
    Total_cost MONEY NOT NULL,
    FOREIGN KEY (Class_of_cabin,Number_of_ship,Serial_of_ship) references Cabin_class,
    PRIMARY KEY (Class_of_cabin,Number_of_ship,Serial_of_ship)
);

CREATE TABLE Table_of_ports(
    Serial_number INT NOT NULL,
    Voyage_number INT NOT NULL REFERENCES Voyage,
    Name_of_port VARCHAR(20) NOT NULL REFERENCES Port,
    Name_of_cargo VARCHAR(20) NULL,
    Class_of_cabin VARCHAR(20) NULL,
    Number_of_ship INT NULL,
    Serial_of_ship VARCHAR(2) NULL,
    CONSTRAINT Table_of_ports_PK PRIMARY KEY (Serial_number,Voyage_number),
    FOREIGN KEY (Class_of_cabin,Number_of_ship,Serial_of_ship) references Price_between_2_ports_PASSENGER,
    FOREIGN KEY (Name_of_cargo,Number_of_ship,Serial_of_ship) references Price_between_2_ports_FREIGHT
);

CREATE TABLE Ticket(
    Identification_code VARCHAR(20) NOT NULL UNIQUE,
    Voyage_number INT NOT NULL REFERENCES Voyage,
    Arrivel_number INT NOT NULL,
    Depart_number INT NOT NULL,
    ID_Client INT NOT NULL REFERENCES Client,
    Class_of_cabin VARCHAR(20) NOT NULL,
    Number_of_ship INT NOT NULL,
    Serial_of_ship VARCHAR(2) NOT NULL,
    Cost_of_ticket MONEY NOT NULL,
    FOREIGN KEY (Class_of_cabin,Number_of_ship,Serial_of_ship) references Cabin_class,
    FOREIGN KEY (Arrivel_number,Voyage_number) references Table_of_ports(Serial_number,Voyage_number),
    FOREIGN KEY (Depart_number,Voyage_number) references Table_of_ports(Serial_number,Voyage_number),
    CHECK(Arrivel_number < Depart_number),
    PRIMARY KEY(Identification_code,Voyage_number)
);

CREATE TABLE Ship_declaration(
    Barcode INT NOT NULL UNIQUE,
    Voyage_number INT NOT NULL REFERENCES Voyage,
    Arrivel_number INT NOT NULL,
    Depart_number INT NOT NULL,
    Name_of_cargo VARCHAR(20) NOT NULL,
    Number_of_ship INT NOT NULL,
    Serial_of_ship VARCHAR(2) NOT NULL,
    ID_Client INT NOT NULL REFERENCES Client,
    Tonnage FLOAT NOT NULL,
    Cost_of_declaration MONEY NOT NULL,
    FOREIGN KEY (Name_of_cargo,Number_of_ship,Serial_of_ship) references Type_of_cargo,
    FOREIGN KEY (Arrivel_number,Voyage_number) references Table_of_ports(Serial_number,Voyage_number),
    FOREIGN KEY (Depart_number,Voyage_number) references Table_of_ports(Serial_number,Voyage_number),
    CHECK(Arrivel_number < Depart_number),
    PRIMARY KEY(Barcode,Voyage_number)
);

CREATE TABLE Ships_voyage(
    Voyage_number INT NOT NULL REFERENCES Voyage,
    Number_of_ship INT NOT NULL,
    Serial_of_ship VARCHAR(2) NOT NULL,
    ID_Capitan INT NOT NULL REFERENCES Capitan,
    Presence_of_support INT NOT NULL,
    CHECK(Presence_of_support > -1),
    FOREIGN KEY (Number_of_ship,Serial_of_ship) references Ship,
    PRIMARY KEY(Voyage_number,Number_of_ship,Serial_of_ship,ID_Capitan)
);


DROP TRIGGER IF EXISTS WRITE_OFF_CHECK ON Ships_voyage CASCADE;
DROP FUNCTION IF EXISTS WRITE_OFF_CHECK();

CREATE FUNCTION WRITE_OFF_CHECK() RETURNS TRIGGER AS $WRITE_OFF_CHECK$
    DECLARE Act_cpy INT;
    BEGIN
        SELECT  Act_of_cancellation INTO Act_cpy FROM Ship WHERE Number_of_ship = NEW.Number_of_ship;
        IF Act_cpy IS NOT NULL THEN
            RAISE EXCEPTION 'THIS SHIP CANNOT TO BE ADD IN VOYAGE BECOUSE HE IS CANCEL';
        END IF;
        RETURN NEW;
    END;
$WRITE_OFF_CHECK$ LANGUAGE plpgsql;

CREATE TRIGGER WRITE_OFF_CHECK
BEFORE INSERT ON Ships_voyage
FOR EACH ROW
EXECUTE PROCEDURE WRITE_OFF_CHECK ();


DROP TRIGGER IF EXISTS Capture_by_pirates ON Ship CASCADE;
DROP FUNCTION IF EXISTS CAPTURE_BY_PIRATES();

CREATE FUNCTION CAPTURE_BY_PIRATES() RETURNS TRIGGER AS $CAPTURE_BY_PIRATES$
    DECLARE Value_of_defense INT;
    DECLARE CPY_ID_CLIENT INT;
    DECLARE CPY_COST MONEY;
    DECLARE CPY_SHIP INT;
    DECLARE CPY_VOYAGE_NUMBER INT;
    BEGIN
        IF NEW.status_of_ship = 'Capture' THEN
            SELECT Presence_of_support INTO Value_of_defense FROM Ships_voyage WHERE Number_of_ship = NEW.Number_of_ship;
            IF Value_of_defense > 1 THEN
                RAISE EXCEPTION 'THIS SHIP CANNOT TO BE CAPTURE';
            ELSE
                IF NEW.serial_of_ship = 'FR' THEN
                    FOR CPY_ID_CLIENT IN
                        SELECT ID_Client FROM Ship_declaration WHERE Number_of_ship = NEW.Number_of_ship
                    LOOP
                        SELECT Cost_of_declaration INTO CPY_COST FROM Ship_declaration WHERE Number_of_ship = NEW.Number_of_ship AND ID_CLIENT = CPY_ID_CLIENT;
                        UPDATE Client SET balance = balance + (CPY_COST * 0.05) WHERE ID_CLIENT = CPY_ID_CLIENT;
                    END LOOP;
                ELSE
                    FOR CPY_ID_CLIENT IN
                        SELECT ID_Client FROM Ticket WHERE Number_of_ship = NEW.Number_of_ship
                    LOOP
                        UPDATE Client SET balance = balance + (average_annual_consumption * 0.1) WHERE ID_CLIENT = CPY_ID_CLIENT;
                    END LOOP;
                END IF;
                IF pg_trigger_depth() < 2 THEN
                    SELECT Voyage_number INTO CPY_VOYAGE_NUMBER FROM Ships_voyage WHERE Number_of_ship = NEW.Number_of_ship;
                    FOR CPY_SHIP IN
                        SELECT Number_of_ship FROM Ships_voyage WHERE Voyage_number = CPY_VOYAGE_NUMBER and Number_of_ship != NEW.Number_of_ship
                    LOOP
                        UPDATE Ship SET Status_of_ship = 'Capture' WHERE Number_of_ship = CPY_SHIP;
                    END LOOP;
                END IF;
            END IF;
        END IF;
        RETURN NEW;
    END;
$CAPTURE_BY_PIRATES$ LANGUAGE plpgsql;

CREATE TRIGGER CAPTURE_BY_PIRATES
BEFORE UPDATE ON Ship
FOR EACH ROW
EXECUTE PROCEDURE CAPTURE_BY_PIRATES();


DROP FUNCTION IF EXISTS building_path(Number_ship_cpy INTEGER, Serial_ship_cpy VARCHAR(2), Start_name_port VARCHAR(20), Final_name_port VARCHAR(20), N INTEGER);

CREATE FUNCTION building_path(Number_ship_cpy INTEGER, Serial_ship_cpy VARCHAR(2), Start_name_port VARCHAR(20), Final_name_port VARCHAR(20), N INTEGER)
RETURNS integer AS $$
    DECLARE ID INT;
    DECLARE ID_CPY INT;
    DECLARE CHECKER_1 INT;
    DECLARE CHECKER_2 INT;
    DECLARE ID_CAP INT;
    DECLARE ID_VOYAGE INT;
    DECLARE X_S FLOAT;
    DECLARE Y_S FLOAT;
    DECLARE X_F FLOAT;
    DECLARE Y_F FLOAT;
    DECLARE Name_of_port_cpy VARCHAR(20);
    DECLARE N_CPY INT;
    DECLARE Distance FLOAT;
    BEGIN
        ID_VOYAGE = 0;
        FOR ID_VOYAGE IN
            SELECT Voyage_number FROM Voyage WHERE Voyage_number > ID_VOYAGE
        LOOP
        END LOOP;

        ID_VOYAGE = ID_VOYAGE + 1;
        Distance = N * 100 + 200;
        INSERT INTO Voyage VALUES(ID_VOYAGE,'20190501 00:00:00','20190601 00:00:00',Distance , 0, 0, 0, 0);

        ID_CPY = 0;
        FOR CHECKER_1 IN
            SELECT id_capitan FROM Ships_voyage WHERE Number_of_ship = Number_ship_cpy
        LOOP
            ID = 0;
            FOR CHECKER_2 IN
                SELECT id_capitan FROM Ships_voyage WHERE Number_of_ship = Number_ship_cpy
            LOOP
                IF CHECKER_1 = CHECKER_2 THEN
                    ID = ID + 1;
                END IF;
            END LOOP;
            IF ID > ID_CPY THEN
                ID_CPY = ID;
                ID_CAP = CHECKER_1;
            END IF;
        END LOOP;

        INSERT INTO Ships_voyage VALUES(ID_VOYAGE,Number_ship_cpy,Serial_ship_cpy,ID_CAP,0);

        SELECT X,Y INTO X_S,Y_S FROM Port WHERE Name_of_port = Start_name_port;
        SELECT X,Y INTO X_F,Y_F FROM Port WHERE Name_of_port = Final_name_port;
        N_CPY = N;

        INSERT INTO Table_of_ports VALUES(1,ID_VOYAGE,Start_name_port, NULL, NULL, NULL, NULL);
        ID = 2;
        IF N_CPY != 0 THEN
            LOOP
                SELECT Name_of_port INTO Name_of_port_cpy FROM Port
                WHERE Name_of_port NOT IN (SELECT Name_of_port FROM Table_of_ports WHERE Voyage_number = ID_VOYAGE)
                AND (X < X_F) AND (Y < Y_F) AND (X > X_S) AND (Y > Y_S);

                INSERT INTO Table_of_ports VALUES(ID,ID_VOYAGE,Name_of_port_cpy, NULL, NULL, NULL, NULL);
                ID = ID + 1;
                N_CPY = N_CPY - 1;
                IF N_CPY = 0 THEN
                    INSERT INTO Table_of_ports VALUES(ID,ID_VOYAGE,Final_name_port, NULL, NULL, NULL, NULL);
                    EXIT;
                END IF;
            END LOOP;
        ELSE
            INSERT INTO Table_of_ports VALUES(ID,ID_VOYAGE,Final_name_port, NULL, NULL, NULL, NULL);
        END IF;
        RETURN 0;
    END;
$$ LANGUAGE plpgsql;


DROP FUNCTION IF EXISTS ticket_seller(Voyage_number_cpy integer);

CREATE FUNCTION ticket_seller(Voyage_number_cpy integer)
RETURNS integer AS $$
    DECLARE SHIP_NUMBER INT;
    DECLARE TYPE_OF_CABIN VARCHAR(20);
    DECLARE NUMBER_OF_TICKETS INT;
    DECLARE COST_OF_PLACE_CPY MONEY;
    DECLARE ID VARCHAR(20);
    DECLARE ID_CLIENT_CPY INT;
    DECLARE RANDOM VARCHAR(20);
    BEGIN
        SELECT Number_of_ship INTO SHIP_NUMBER FROM Ships_voyage WHERE Voyage_number = Voyage_number_cpy AND Serial_of_ship = 'PA';
        IF SHIP_NUMBER IS NULL THEN
            RAISE EXCEPTION 'TICKETS CANNOT BE SOLD BECOUSE PASSENGER SHIP NOT ADD IN THIS VOYAGE';
        END IF;

        FOR NUMBER_OF_TICKETS,TYPE_OF_CABIN,COST_OF_PLACE_CPY IN
            SELECT Number_of_places,Cabin_of_class,Cost_of_cabin FROM Cabin_class WHERE Number_of_ship = SHIP_NUMBER
        LOOP
            FOR ID IN
                SELECT Identification_code FROM Ticket
                WHERE Number_of_ship = SHIP_NUMBER AND Voyage_number = Voyage_number_cpy AND Class_of_cabin = TYPE_OF_CABIN
            LOOP
                NUMBER_OF_TICKETS = NUMBER_OF_TICKETS - 1;
            END LOOP;
            IF NUMBER_OF_TICKETS != 0 THEN
                FOR ID_CLIENT_CPY IN
                    SELECT Id_client FROM Client
                    WHERE Id_client NOT IN
                    (SELECT Id_client FROM Ticket WHERE Number_of_ship = SHIP_NUMBER AND Voyage_number = Voyage_number_cpy)
                    ORDER BY Average_annual_consumption
                LOOP
                    IF ID_CLIENT_CPY IS NULL THEN
                        RAISE NOTICE 'ALL CLIENTS HAVE TICKETS';
                        RETURN 0;
                    ELSIF NUMBER_OF_TICKETS != 0  THEN
                        SELECT floor(random() * 100000 + 1)::int INTO RANDOM;
                        RANDOM = CAST(RANDOM AS VARCHAR(20));
                        WHILE RANDOM IN (SELECT Identification_code FROM Ticket) LOOP
                            SELECT floor(random() * 100000 + 1)::int INTO RANDOM;
                            RANDOM = CAST(RANDOM AS VARCHAR(20));
                        END LOOP;
                        INSERT INTO Ticket VALUES(RANDOM,Voyage_number_cpy,1,2,ID_CLIENT_CPY,TYPE_OF_CABIN,SHIP_NUMBER,'PA',COST_OF_PLACE_CPY);
                        NUMBER_OF_TICKETS = NUMBER_OF_TICKETS - 1;
                    END IF;
                END LOOP;
            END IF;
        END LOOP;
        RETURN 0;
    END;
$$ LANGUAGE plpgsql;







INSERT INTO Capitan
	VALUES(1,'Kasatkin','Illia','Andreevich','FA19213',5,true),
	(2,'Komarov','Victor','Ala','19213',5,true),
	(3,'Alekseev','Vasilii','Bala','FA9432',1,true),
	(4,'Lebedev','Petr','Koala','FA1563',1,true),
	(5,'Ahmadov','Artem','Amalgama','FA2',5,true),
  (6,'Kasatkin','Andrei','Victorovich','FA132',5,true),
	(7,'Volkova','Dobrynya','Nikitich','FA144',5,true),
	(8,'Banzai','Illia','Murovich','2344 234234',5,false),
	(9,'Grechka','Ramen','Davidovich','F234432',20,true),
	(10,'Raq','Doshirak','Pureshkovich','234324',5,true),
	(11,'Xiaomi','Rolton','Lapshikovich','edsdsf2',5,true),
	(12,'Huawei','Chan','Ramenovich','Fdddd33',5,true),
	(13,'Samsung','Kudesnik','Prekrasnii','4563',5,true),
	(14,'Asus','Mag','Gendalfovich','78787',5,true),
	(15,'Acer','Golum','Bagens','967',5,true);

INSERT INTO Ship
	VALUES(7,'FR','Pobeda','19990110',192000, NULL, 'In port','A'),
	(1,'PA','Sun','20041210',20000, NULL, 'In remont','C'),
	(6,'PA','Gus','20030110',1500, NULL, 'In port','B'),
	(2,'PA','Paradise','19800110',30000, NULL, 'In port','C'),
	(3,'PA','Cisco','19900110',1000000, NULL, 'Na dne','A'),
	(4,'FR','Fujon','19600110',192, NULL, 'In ocean','A'),
	(5,'FR','Lokam','10001010',112000, NULL, 'In sea','A'),
	(8,'FR','Trash','19990110',13200, NULL, 'In lake','B'),
	(9,'PA','Goldberg','16000110',200000, NULL, 'In river','C'),
	(10,'FR','Silverbaum','15000110',3600, NULL, 'In land','B'),
	(11,'FR','Riki','19990920',1, NULL, 'In port','C'),
	(12,'PA','Morti','20190910',2, NULL, 'In port','C'),
	(13,'FR','Pharaoh','20300227',3, NULL, 'In port','C'),
	(14,'FR','Krasotka','20300227',3, 213, 'In port','C'),
	(15,'PA','Sherlock','20300227',3, NULL, 'In port','C');

INSERT INTO Port
	VALUES('Montecarlo','Spanish','Moscow', 1, 1, 100, 100),
	('Ufc','Russia','Madrid', 1, 4, 200, 200),
	('Fifa','Bali','Barcelone', 4, 1, 300, 300),
	('Domodedovo','Italy','London', 4, 4, 400, 600),
	('Stolichka','Kasakhstan','Nursultan', 4, 2, 500, 500),
	('Monaliza','United','Saintpetersburg', 2, 2, 100, 600),
	('Davinchi','Germany','Donetsk', 2, 1, 800, 900),
	('Letai','China','Siria', 1, 2, 12300, 12300),
	('Palm','Japan','Kamboji', 3, 3, 145, 116),
	('Dinasty','Spanish','Norilsk', 3, 2, 178, 2132),
	('Nrage','Moscow','Ufa', 2, 3, 2300, 3210),
	('Siemens','Moscow','Kazanb', 2, 4, 300, 8600),
	('Lalaland','Litva','Groznii', 3, 4, 6700, 5400);

INSERT INTO Voyage
	VALUES(3,'20300110 04:05:06','20300110 08:05:06', 500, 15, 20, 30, 10),
	(2,'20300110 23:00:00','20300110 00:00:00', 300, 10, 30, 45, 20),
	(1,'20300110 03:30:06','20300110 05:32:15', 400, 20, 40, 60, 30),
	(4,'20300110 12:05:06','20300110 17:04:00', 200, 5, 50, 75, 40),
	(5,'20300110 12:05:06','20300110 17:04:00', 200, 5, 50, 75, 40),
	(10,'20300110 12:05:06','20300110 17:04:00', 200, 5, 50, 75, 40);

INSERT INTO Client
	VALUES(117,'Bobilev','Yaroslav','Sergeevich', 'POP123', decode('013d7d16d7ad4fefb61bd95b765c8ceb', 'hex'), '00000000001', 10000, 100000),
	(1,'Popov','Grigorii','Andreevich', '9213 9219391', decode('007687fc64b746569616414b78c81ef1', 'hex'), '00000003001', 5000, 50000),
	(25,'Kasatkina','Anna','Dmitrievna', 'asd123', decode('3931383D38', 'hex'), '00000412301', 3000, 30000),
	(46,'Astapov','Ruslan','Luterovich', 'AS82123', decode('3931383D38', 'hex'), '12340003001',300, 30000),
	(2,'Minina','Daria','Vladislavovna', '12321', decode('3931383D38', 'hex'), '2',5000, 50000),
	(3,'Pepelsin','Andrei','Antonovich', '87867', decode('3931383D38', 'hex'), '3',5000, 60000),
	(4,'Antipov','Victor','Stark', '6546', decode('3931383D38', 'hex'), '4',5000, 80000),
	(5,'Kolesnikov','Bilbo','Hodorovich', '0', decode('3931383D38', 'hex'), '5',5000, 90000),
	(6,'Longus','Augistian','Bastard', '1', decode('3931383D38', 'hex'), '6',5000, 90000),
	(7,'Brons','Huares','Noch', '2', decode('3931383D38', 'hex'), '7',5000, 90000),
	(8,'Opov','Jorge','Illias', '3', decode('3931383D38', 'hex'), '8',5000, 90000),
	(9,'Elkin','Messi','Engelsovich', '4', decode('3931383D38', 'hex'), '9',5000, 90000),
	(10,'Churchill','Cristiano','Frankenstein', '5', decode('3931383D38', 'hex'), '10',5000, 90000),
	(11,'Tecther','Margaret','Savina', '6', decode('3931383D38', 'hex'), '11',5000, 90000);

INSERT INTO Freight
	VALUES(7,'FR', 1000),
	(4,'FR', 1000),
	(11,'FR', 1000),
	(10,'FR', 1000);

INSERT INTO Passenger
	VALUES(1,'PA', 7),
	(6,'PA', 7),
	(2,'PA', 7),
	(3,'PA', 7),
	(15,'PA', 4);

INSERT INTO Cabin_class
	VALUES('LUX',1,'PA', 4, 2000),
	('STANDART',1,'PA', 3, 1000),
	('LUX',6,'PA', 4, 2000),
	('STANDART',6,'PA', 3, 1000),
    ('LUX',2,'PA', 4, 2000),
	('STANDART',2,'PA', 3, 1000),
    ('LUX',3,'PA', 4, 2000),
	('STANDART',3,'PA', 3, 1000),
	('LUX',15,'PA', 2, 2000),
	('STANDART',15,'PA', 2, 1000);

INSERT INTO Type_of_cargo
	VALUES('CARS',7,'FR', 300, 200000),
	('GOLDS',10,'FR', 400, 1000000),
	('PROCESSORS',10,'FR', 200, 30000);

INSERT INTO Price_between_2_ports_PASSENGER
	VALUES('LUX','Montecarlo','Monaliza', 1,'PA', 200),
	('STANDART','Lalaland','Letai', 1,'PA', 700),
	('LUX','Montecarlo','Monaliza', 6,'PA', 200),
	('STANDART','Lalaland','Letai', 6,'PA', 700),
	('LUX','Montecarlo','Monaliza', 2,'PA', 200),
	('STANDART','Lalaland','Letai', 2,'PA', 700),
	('LUX','Montecarlo','Monaliza', 3,'PA', 200),
	('STANDART','Lalaland','Letai', 3,'PA', 700);

INSERT INTO Price_between_2_ports_FREIGHT
	VALUES('GOLDS','Monaliza','Dinasty', 10,'FR', 500),
	('PROCESSORS','Dinasty','Lalaland', 10,'FR', 600),
	('CARS','Lalaland','Letai', 7,'FR', 700);

INSERT INTO Table_of_ports
	VALUES(1,1,'Montecarlo', NULL, NULL, 1,'PA'),
	(2,1,'Monaliza', NULL, NULL, 1,'PA'),
	(3,1,'Dinasty',NULL, NULL, 1,'PA'),
	(4,1,'Lalaland', NULL, NULL, 1,'PA'),
	(1,2,'Montecarlo', 'CARS',NULL, 7,'FR'),
	(2,2,'Monaliza','CARS',NULL,7,'FR'),
	(3,2,'Lalaland', 'CARS',NULL, 7,'FR'),
	(4,2,'Letai', 'CARS',NULL, 7,'FR'),
	(1,3,'Montecarlo', NULL, NULL, 6,'PA'),
	(2,3,'Monaliza', NULL, NULL, 6,'PA'),
	(3,3,'Dinasty', NULL, NULL, 6,'PA'),
	(4,3,'Lalaland', NULL, NULL, 6,'PA'),
	(1,4,'Montecarlo', NULL, NULL, 2,'PA'),
	(2,4,'Monaliza',NULL, NULL, 2,'PA'),
	(3,4,'Dinasty', NULL, NULL, 2,'PA'),
	(4,4,'Lalaland', NULL, NULL, 2,'PA'),
	(1,5,'Montecarlo', NULL, NULL, 3,'PA'),
	(2,5,'Monaliza', NULL, NULL, 3,'PA'),
	(3,5,'Dinasty', NULL, NULL, 3,'PA'),
	(4,5,'Lalaland', NULL, NULL, 3,'PA'),
	(1,10,'Dinasty', NULL, NULL, 15,'PA'),
	(2,10,'Lalaland', NULL, NULL, 15,'PA');

INSERT INTO Ticket
	VALUES('S123U8',1,1,2,1,'LUX',1,'PA',2500),
	('S143U8',1,3,4,25,'STANDART',1,'PA',1500),
	('S153U8',1,1,4,46,'LUX',1,'PA',2000),
	('S0000',4,1,4,2,'LUX',6,'PA',2000),
	('1',4,1,4,3,'LUX',6,'PA',2000),
	('2',4,1,4,4,'LUX',6,'PA',2000),
	('3',4,1,4,5,'LUX',6,'PA',2000),
	('5',1,1,4,10,'LUX',3,'PA',2000),
	('4',3,1,4,6,'LUX',2,'PA',2000),
	('8',10,1,2,46,'LUX',15,'PA',2000);

INSERT INTO Ship_declaration
	VALUES(12345,2,1,2,'CARS',7,'FR',117,20000,1000000),
	(54321,2,3,4,'GOLDS',10,'FR',9,30000,10000000),
	(23456,2,1,4,'PROCESSORS',10,'FR',9,40000,10000);

INSERT INTO Ships_voyage
	VALUES(2,7,'FR',5,0),
	(2,14,'FR',4,0);

INSERT INTO Ships_voyage
	VALUES(2,7,'FR',5,0);

INSERT INTO Ships_voyage
	VALUES(1,1,'PA',1,0),
	(4,6,'PA',1,1),
	(3,2,'PA',5,2),
	(1,3,'PA',9,0);

INSERT INTO Ships_voyage
	VALUES(5,8,'FR',14,2),
	    (5,8,'FR',15,2),
	    (3,8,'FR',15,2);

INSERT INTO Ships_voyage
	VALUES(10,15,'PA',10,0);

UPDATE Ship SET Status_of_ship = 'Capture' WHERE Number_of_ship = 7 and Serial_of_ship = 'FR';
UPDATE Ship SET Status_of_ship = 'Capture' WHERE Number_of_ship = 1 and Serial_of_ship = 'PA';
UPDATE Ship SET Status_of_ship = 'Capture' WHERE Number_of_ship = 6 and Serial_of_ship = 'PA';
UPDATE Ship SET Status_of_ship = 'Capture' WHERE Number_of_ship = 2 and Serial_of_ship = 'PA';

SELECT building_path(8,'FR','Montecarlo','Domodedovo',3);

SELECT ticket_seller(10);