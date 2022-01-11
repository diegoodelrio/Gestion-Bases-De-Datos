DROP DATABASE animalario;
CREATE DATABASE animalario;
USE animalario;

CREATE TABLE Poblacion(
    reference INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    researcher VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    num_days INT NOT NULL CHECK(num_days <= 270)
)ENGINE=INNODB;


CREATE TABLE Raton(
    reference INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birthdate DATE NOT NULL,
    temperature FLOAT NOT NULL,
    weight FLOAT NOT NULL, 
    description VARCHAR(255),
    gender ENUM("MALE", "FEMALE") NOT NULL,
    chromosome1 VARCHAR(255) NOT NULL,
    chromosome2 VARCHAR(255) NOT NULL,
    ref_poblacion INT NOT NULL,
    ref_cria INT
)ENGINE=INNODB;


CREATE TABLE Familia(
    reference INT PRIMARY KEY,
    ref_padre INT NOT NULL UNIQUE,
    ref_poblacion INT NOT NULL
)ENGINE=INNODB;


CREATE TABLE Familia_normal(
    ref_familia INT PRIMARY KEY,
    ref_madre_normal INT NOT NULL UNIQUE
)ENGINE=INNODB;


CREATE TABLE Familia_poligamica(
    ref_familia INT  PRIMARY KEY
)ENGINE=INNODB;

ALTER TABLE Raton ADD FOREIGN KEY (ref_cria) REFERENCES Raton(reference) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Raton ADD FOREIGN KEY (ref_poblacion) REFERENCES Poblacion(reference) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Familia ADD FOREIGN KEY (ref_poblacion) REFERENCES Poblacion(reference) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Familia ADD FOREIGN KEY (ref_padre) REFERENCES Raton(reference) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Familia_normal ADD FOREIGN KEY (ref_madre_normal) REFERENCES Raton(reference) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Familia_normal ADD FOREIGN KEY (ref_familia) REFERENCES Familia(reference) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Familia_poligamica ADD FOREIGN KEY (ref_familia) REFERENCES Familia(reference) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Raton ADD ref_familia_poligamica INT DEFAULT NULL;
ALTER TABLE Raton ADD FOREIGN KEY (ref_familia_poligamica) REFERENCES Familia(reference) ON DELETE CASCADE ON UPDATE CASCADE;

--2.Creamos una poblacion virtual de ratones a partir del tamaño de una poblacion--
INSERT INTO Poblacion (reference, name, researcher, start_date, num_days) VALUES 
(1, "population3", "researcher6", "2020-03-24", 270);

INSERT INTO Raton (reference, name, birthdate, temperature, weight, description, gender, chromosome1, chromosome2, ref_poblacion) VALUES 
(1, "mouse5", "2020-03-24", 37.002404311104414, 82.1681332014487, " ", "MALE", "X", "Y", 1),
(2, "mouse4", "2020-03-24", 36.03022658534787, 90.42843354713528, " ", "MALE", "X", "Y", 1),
(3, "mouse5", "2020-03-24", 37.067816792696924, 68.72470162207557, " ", "MALE", "X", "Y", 1),
(4, "mouse5", "2020-03-24", 37.67733734998302, 95.1128872038328, " ", "MALE", "X", "Y", 1),
(5, "mouse4", "2020-03-24", 36.9108034198278, 54.30286325897043, " ", "MALE", "X", "Y", 1),
(6, "mouse1", "2020-03-24", 37.833708127606556, 93.76053460858095, " ", "MALE", "X", "Y", 1),
(7, "mouse6", "2020-03-24", 36.818153386568774, 74.33623104589677, " ", "MALE", "X", "Y", 1),
(8, "mouse1", "2020-03-24", 37.908433165791195, 56.53580866718229, " ", "MALE", "X", "Y", 1),
(9, "mouse3", "2020-03-24", 36.50946173128273, 65.22607078471115, " ", "MALE", "X", "Y", 1),
(10, "mous1", "2020-03-24", 37.755082208578905, 88.5879981038425, " ", "MALE", "X", "Y", 1),
(11, "mouse4", "2020-03-24", 36.85336284914176, 96.4611827831698, " ", "MALE", "X", "Y", 1),
(12, "mouse6", "2020-03-24", 37.86430703005974, 70.27935147558456, " ", "MALE", "X", "Y", 1),
(13, "mouse2", "2020-03-24", 37.33081483518706, 88.38768036894393, " ", "MALE", "X", "Y", 1),
(14, "mouse5", "2020-03-24", 36.61234652478345, 50.49519907752422, " ", "MALE", "X_MUTATED", "Y", 1),
(15, "mouse4", "2020-03-24", 37.81957483314564, 52.54845619757628, " ", "MALE", "X", "Y_MUTATED", 1),
(16, "mouse4", "2020-03-24", 37.433875616699794, 68.71924710666156, " ", "MALE", "X", "Y_MUTATED", 1),
(17, "mouse2", "2020-03-24", 37.157888669303986, 72.80738853512165, " ", "FEMALE", "X", "X", 1),
(18, "mouse4", "2020-03-24", 37.883520936511516, 74.75956732414261, " ", "FEMALE", "X", "X", 1),
(19, "mouse3", "2020-03-24", 36.7706887486517, 97.87824097355929, " ", "FEMALE", "X", "X", 1),
(20, "mouse3", "2020-03-24", 37.52084308706882, 64.58315044938539, " ", "FEMALE", "X", "X", 1),
(21, "mouse5", "2020-03-24", 37.384955307936465, 81.29072987064134, " ", "FEMALE", "X", "X", 1),
(22, "mouse3", "2020-03-24", 37.1090423281101, 53.609419091355534, " ", "FEMALE", "X", "X", 1),
(23, "mouse4", "2020-03-24", 37.89015926182535, 71.47626341408183, " ", "FEMALE", "X", "X", 1),
(24, "mouse2", "2020-03-24", 36.823470368294124, 81.52738186901125, " ", "FEMALE", "X", "X", 1),
(25, "mouse2", "2020-03-24", 37.16069522797544, 90.19448857069082, " ", "FEMALE", "X", "X", 1),
(26, "mouse6", "2020-03-24", 37.5303448387964, 62.60396055520084, " ", "FEMALE", "X", "X", 1),
(27, "mouse3", "2020-03-24", 36.482357109689424, 87.61279718996084, " ", "FEMALE", "X", "X", 1),
(28, "mouse4", "2020-03-24", 36.31214417238877, 95.07987383107607, " ", "FEMALE", "X", "X", 1),
(29, "mouse6", "2020-03-24", 36.75377548590471, 52.03669560038681, " ", "FEMALE", "X", "X", 1),
(30, "mouse3", "2020-03-24", 36.06857001316401, 90.56858166132676, " ", "FEMALE", "X", "X", 1),
(31, "mouse3", "2020-03-24", 36.27423611160186, 51.911530275050374, " ", "FEMALE", "X", "X", 1),
(32, "mouse6", "2020-03-24", 37.579531546920066, 95.47141111342984, " ", "FEMALE", "X", "X", 1),
(33, "mouse5", "2020-03-24", 37.55279227812015, 84.58042828512363, " ", "FEMALE", "X", "X", 1),
(34, "mouse5", "2020-03-24", 37.820321586892156, 55.01677006959715, " ", "FEMALE", "X", "X", 1),
(35, "mouse5", "2020-03-24", 36.517828902040236, 80.66821503486213, " ", "FEMALE", "X", "X", 1),
(36, "mouse4", "2020-03-24", 37.561258240393904, 64.37322299523895, " ", "FEMALE", "X", "X", 1),
(37, "mouse2", "2020-03-24", 36.481066120786835, 56.17776202770728, " ", "FEMALE", "X_MUTATED", "X_MUTATED", 1),
(38, "mouse5", "2020-03-24", 37.74182622807914, 80.71182621864997, " ", "FEMALE", "X_MUTATED", "X_MUTATED", 1),
(39, "mouse4", "2020-03-24", 37.89137142120088, 67.45762876878808, " ", "FEMALE", "X_MUTATED", "X_MUTATED", 1),
(40, "mouse3", "2020-03-24", 36.8978539733149, 85.70655820754669, " ", "FEMALE", "X_MUTATED", "X_MUTATED", 1);

--3.Creamos una nueva poblacion de ratones vacia--
INSERT INTO Poblacion (reference, name, researcher, start_date, num_days) VALUES 
(2, "pupulation5", "researcher7", "2020-03-24", 250);

--4.Listar los codigos de referencia de los ratones de una poblacion--
select reference from Raton
where ref_poblacion=1;

--5.Añadir un nuevo raton a una poblacion ya existente indicando todos sus datos--
INSERT INTO Raton (reference, name, birthdate, temperature, weight, description, gender, chromosome1, chromosome2, ref_poblacion) VALUES
(41, "mouse6", "2020-03-24", 36.637237238877, 80.76821503486213, " ", "MALE", "X", "Y", 1);
select * from Raton where reference = 41;

--6.Añadir un nuevo ratón a una población ya existente--
INSERT INTO Raton (reference, name, birthdate, temperature, weight, description, gender, chromosome1, chromosome2, ref_poblacion) VALUES
(42, "mouse5", "2020-03-24", 37.637237238877, 81.76821503486213, " ", "FEMALE", "X", "X", 1);

--7.Eliminar un raton de una poblacion indicando su numero de referencia--
delete from Raton
where reference=12;

--8.Modificar los datos de un raton indicando el numero de referencia--
update Raton
set name = "DIEGO" where reference = 19;
select * from Raton where reference = 19;

--9.Ver informacion detallada de un raton indicando su numero de referencia--
select * from Raton
where reference=19;

--Ejercicio 10--
INSERT INTO familia (reference, ref_padre, ref_poblacion) VALUES (1, 1, 1);
INSERT INTO familia (reference, ref_padre, ref_poblacion) VALUES (2, 2, 1);
INSERT INTO familia (reference, ref_padre, ref_poblacion) VALUES (3, 3, 1);
INSERT INTO familia (reference, ref_padre, ref_poblacion) VALUES (4, 4, 1);
INSERT INTO familia (reference, ref_padre, ref_poblacion) VALUES (5, 5, 1);
INSERT INTO familia (reference, ref_padre, ref_poblacion) VALUES (6, 6, 1);
INSERT INTO familia (reference, ref_padre, ref_poblacion) VALUES (7, 7, 1);

INSERT INTO familia_normal (ref_familia, ref_madre_normal) VALUES (1, 20);
INSERT INTO familia_normal (ref_familia, ref_madre_normal) VALUES (2, 21);
INSERT INTO familia_normal (ref_familia, ref_madre_normal) VALUES (3, 22);

insert into Familia_poligamica (ref_familia) values (7);
update Raton
set ref_familia_poligamica = 7
where reference = 37;
update Raton 
set ref_familia_poligamica = 7
where reference = 38;
update Raton
set ref_familia_poligamica = 7
where reference = 39;
update Raton
set ref_familia_poligamica = 7
where reference = 40;
select * from Raton;

--Ejercicio 11--

INSERT INTO Raton (reference, name, birthdate, temperature, weight, description, gender, chromosome1, chromosome2, ref_poblacion, ref_cria) VALUES (43, "mouse2", "2020-03-24", 37.33081483518706, 88.38768036894393, " ", "MALE", "X", "Y", 1, 13);
INSERT INTO Raton (reference, name, birthdate, temperature, weight, description, gender, chromosome1, chromosome2, ref_poblacion, ref_cria) VALUES (44, "mouse4", "2020-03-24", 36.85336284914176, 96.4611827831698, " ", "MALE", "X", "Y", 1, 11);



