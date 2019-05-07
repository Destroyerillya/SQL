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
	VALUES(7,'FR','Pobeda','19990110',300, NULL, 'In port','A'),
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
	(1,2,'Ufc', 'CARS',NULL, 7,'FR'),
	(2,2,'Fifa','CARS',NULL,7,'FR'),
	(3,2,'Davinchi', 'CARS',NULL, 7,'FR'),
	(4,2,'Letai', 'CARS',NULL, 7,'FR'),
	(1,3,'Nrage', NULL, NULL, 6,'PA'),
	(2,3,'Dinasty', NULL, NULL, 6,'PA'),
	(3,3,'Palm', NULL, NULL, 6,'PA'),
	(4,3,'Lalaland', NULL, NULL, 6,'PA'),
	(1,4,'Stolichka', NULL, NULL, 2,'PA'),
	(2,4,'Siemens',NULL, NULL, 2,'PA'),
	(3,4,'Dinasty', NULL, NULL, 2,'PA'),
	(4,4,'Nrage', NULL, NULL, 2,'PA'),
	(1,5,'Montecarlo', NULL, NULL, 3,'PA'),
	(2,5,'Letai', NULL, NULL, 3,'PA'),
	(3,5,'Dinasty', NULL, NULL, 3,'PA'),
	(4,5,'Stolichka', NULL, NULL, 3,'PA'),
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
	VALUES(1,8,'FR',14,2),
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

--- SELECT 1
WITH MAXCOSTER AS(
    SELECT * FROM (SELECT number_of_ship, SUM(cost_of_ticket) AS COST
                     FROM Ticket
                     GROUP BY number_of_ship) T FULL JOIN (SELECT number_of_ship,SUM(cost_of_declaration) AS COST
                    FROM ship_declaration
                    GROUP BY number_of_ship) K USING(number_of_ship,COST)
)
SELECT * FROM MAXCOSTER
WHERE COST = (SELECT MAX(COST) FROM MAXCOSTER);

--- SELECT 2
SELECT DISTINCT Name_of_port FROM Port
WHERE Name_of_port NOT IN (SELECT Name_of_port FROM Table_of_ports WHERE Voyage_number IN
                                                                         (SELECT Voyage_number FROM Ships_voyage WHERE Number_of_ship = 7)) AND
      Name_of_port IN (SELECT Name_of_port FROM Table_of_ports WHERE Voyage_number IN
                                                                         (SELECT Voyage_number FROM Ships_voyage WHERE Number_of_ship = 8))
ORDER BY Name_of_port;


--- SELECT 3
SELECT Voyage_number,Number_of_ship FROM Ships_voyage
WHERE Voyage_number IN (SELECT Voyage_number FROM Ships_voyage GROUP BY Voyage_number HAVING count(*) > 1)
ORDER BY Voyage_number;

--- SELECT 3(2)
WITH FLOTILIAS AS(
    SELECT Voyage_number,Number_of_ship FROM Ships_voyage
    WHERE Voyage_number IN (SELECT Voyage_number FROM Ships_voyage GROUP BY Voyage_number HAVING count(*) > 1)
)
SELECT * FROM FLOTILIAS
ORDER BY voyage_number,number_of_ship;

--- SELECT 3(3)
SELECT Voyage_number,Number_of_ship FROM Ships_voyage
GROUP BY Voyage_number,number_of_ship
HAVING Voyage_number IN (SELECT Voyage_number FROM Ships_voyage GROUP BY Voyage_number HAVING count(*) > 1)
ORDER BY voyage_number,number_of_ship;

--- SELECT 4
WITH MAXCOSTER AS(
    SELECT * FROM (SELECT number_of_ship, SUM(cost_of_ticket) AS COST
                     FROM Ticket
                     GROUP BY number_of_ship) T FULL JOIN (SELECT number_of_ship,SUM(cost_of_declaration) AS COST
                    FROM ship_declaration
                    GROUP BY number_of_ship) K USING(number_of_ship,COST)
)
SELECT * FROM MAXCOSTER
WHERE number_of_ship NOT IN (SELECT number_of_ship FROM Ship WHERE Cost_of_annual_maintenance < COST)
--- OR
WITH MAXCOSTER AS(
    SELECT number_of_ship, SUM(cost_of_ticket) AS COST
    FROM Ticket
    GROUP BY number_of_ship
)
SELECT * FROM MAXCOSTER
WHERE number_of_ship IN (SELECT number_of_ship FROM Ship WHERE Cost_of_annual_maintenance < COST)
ORDER BY number_of_ship;

--- SELECT 5
WITH CountsInfo AS
(
    SELECT id_client,
        COUNT(id_client) AS COUNTS
    FROM Ticket
    GROUP BY id_client
)
SELECT id_client,MAX(COUNTS)FROM CountsInfo
WHERE COUNTS = (SELECT MAX(COUNTS) FROM CountsInfo)
GROUP BY id_client
ORDER BY id_client;