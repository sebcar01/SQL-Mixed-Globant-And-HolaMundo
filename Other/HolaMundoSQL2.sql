CREATE TABLE user (
	id int not null auto_increment,
    name varchar(50) not null,
    edad int not null,
    email varchar(100) not null,
    primary key (id)
);

INSERT INTO user (name, edad, email) 
VALUES
	('Oscar', 25, 'oscar@gmail.com'),
    ('Layla', 15, 'layla@gmail.com'),
    ('Nicolas', 36, 'nico@gmail.com'),
    ('Chanchito', 7, 'chanchis@gmail.com');
    
SELECT * FROM user;
SELECT * FROM user LIMIT 1;
SELECT * FROM user WHERE edad > 20;
SELECT * FROM user WHERE edad >= 15;
SELECT * FROM user WHERE edad > 20 AND email = 'nico@gmail.com';
SELECT * FROM user WHERE edad > 20 OR email = 'layla@gmail.com';
SELECT * FROM user WHERE email != 'layla@gmail.com';
SELECT * FROM user WHERE edad BETWEEN 15 AND 30;
SELECT * FROM user WHERE email LIKE '%gmail%';
SELECT * FROM user WHERE email LIKE '%gmail';
SELECT * FROM user WHERE email LIKE 'gmail%';

SELECT * FROM user;
SELECT * FROM user WHERE name LIKE 'o____';
SELECT * FROM user ORDER BY name ASC;
SELECT * FROM user ORDER BY name ASC;
SELECT max(id) AS ListaCompleta FROM user;

SELECT * FROM user;