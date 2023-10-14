CREATE TABLE products (
	id int not null auto_increment,
    name varchar(50) not null,
    created_by int not null,
    marca varchar(50) not null,
    primary key (id),
    foreign key (created_by) references user (id)
);

RENAME TABLE products TO product;

INSERT INTO product (name, created_by, marca) 
VALUES
	('iPad', 1, 'apple'),
    ('iPhone', 1, 'apple'),
    ('iWatch', 2, 'apple'),
    ('Macbook', 1, 'apple'),
    ('iMac', 3, 'apple'),
    ('iPad Mini', 2, 'apple');
    
SELECT * FROM product;

INSERT INTO product (name, created_by, marca) VALUES ('Oscar', 3, 'samsung');

SELECT u.name, p.name FROM user u JOIN product p ON u.name = p.name;
SELECT u.name, p.name FROM user u LEFT JOIN product p ON u.name = p.name;
SELECT u.name, p.name FROM user u RIGHT JOIN product p ON u.name = p.name;

SELECT u.name as Nombre, p.name as Producto FROM user u JOIN product p ON u.id = p.created_by;
SELECT u.name as Nombre, p.name as Producto FROM user u LEFT JOIN product p ON u.id = p.created_by;
SELECT u.name as Nombre, p.name as Producto FROM user u RIGHT JOIN product p ON u.id = p.created_by;

SELECT u.id, u.name, p.id, p.name FROM user u CROSS JOIN product p;

SELECT COUNT(p.id), u.name FROM product p LEFT JOIN user u ON p.created_by = u.id GROUP BY p.created_by HAVING COUNT(p.id) >= 3;

DROP TABLE product;
DROP TABLE animales;
DROP TABLE user;

CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)