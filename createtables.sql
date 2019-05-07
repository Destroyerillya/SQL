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
    Cost_of_annual_maintenance MONEY NOT NULL,
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
        SELECT Act_of_cancellation INTO Act_cpy FROM Ship WHERE Number_of_ship = NEW.Number_of_ship;
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