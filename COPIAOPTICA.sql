DROP DATABASE IF EXISTS CULAMPOLLA;

CREATE DATABASE CULAMPOLLA CHARACTER SET utf8mb4 ;

USE CULAMPOLLA ;

-- CREACIÓ TAULES

CREATE TABLE suppliers (
    supplierId INT(6) NOT NULL AUTO_INCREMENT,
    supplierName VARCHAR(25) NOT NULL,
    supplierCellNumber VARCHAR(20),
    supplierFax VARCHAR(20),
    supplierNIF VARCHAR(9),
    PRIMARY KEY(supplierId)
);

CREATE TABLE clients (
    clientId INT(6) NOT NULL AUTO_INCREMENT,
    clientName VARCHAR(25) NOT NULL,
    clientCellNumber VARCHAR(16),
    clientEmail VARCHAR(16),
    clientDateRegister DATE,
    clientRecommended INT(6),
    PRIMARY KEY(clientId),
    FOREIGN KEY (clientRecommended) REFERENCES clients(clientId)
);

CREATE TABLE employees (
    employeeId INT(6) NOT NULL AUTO_INCREMENT,
    employeeName VARCHAR(25) NOT NULL,
    employeeCellNumber VARCHAR(16),
    employeeEmail VARCHAR(16),
    PRIMARY KEY(employeeId)
);

CREATE TABLE glasses (
    glassId INT(6) NOT NULL AUTO_INCREMENT,
    supplierId INT(6) NOT NULL,
    clientId INT(6) NOT NULL,
    employeeId INT(6) NOT NULL,
    glassBrand VARCHAR(25) NOT NULL,
    glassRightLensGraduation FLOAT,
    glassLeftLensGraduation FLOAT,
    glassFrame ENUM ('Float', 'Pasta', 'Metallic'),
    glassColorFrame VARCHAR(25),
    glassColorLens VARCHAR(25),
    glassPrice DECIMAL (5, 2),
    glassSellingDate DATE,
    PRIMARY KEY(glassId),
    FOREIGN KEY (supplierId) REFERENCES suppliers(supplierId),
    FOREIGN KEY (clientId) REFERENCES clients(clientId),
    FOREIGN KEY (employeeId) REFERENCES employees(employeeId)
);

CREATE TABLE addresses (
    addressId INT(6) NOT NULL AUTO_INCREMENT,
    supplierId INT(6),
    clientId INT(6),
    street VARCHAR(30),
    num VARCHAR(5),
    flat VARCHAR(3),
    door VARCHAR(3),
    city VARCHAR(20),
    postalCode VARCHAR(10),
    country VARCHAR(20),
    PRIMARY KEY(addressId),
    FOREIGN KEY(supplierId) REFERENCES suppliers(supplierId),
    FOREIGN KEY(clientId) REFERENCES clients(clientId)
);

-- INSERT DATA

INSERT INTO
    suppliers(
        supplierName,
        supplierCellNumber,
        supplierFax,
        supplierNIF
    )
VALUES
    (
        'General',
        '+34 616 620 419',
        '+34 334 566 700',
        'A56778991'
    ),
    (
        'BigTwo',
        '+34 663 776 554',
        '+34 200 789 999',
        'B34567777'
    );

INSERT INTO
    clients(
        clientName,
        clientCellNumber,
        clientEmail,
        clientDateRegister,
        clientRecommended
    )
VALUES
    (
        'Maria Cusell',
        '+34 616 620 419',
        'maria@gmail.com',
        '2010-09-12',
        NULL
    ),
    (
        'Enric Mayne',
        '+34 663 776 554',
        'enric@gmail.com',
        '2011-01-22',
        1
    );

INSERT INTO
    employees(employeeName, employeeCellNumber, employeeEmail)
VALUES
    ('Ana Tapias', '+34 555 444 222', 'ana@gmail'),
    (
        'Pati Jimenez',
        '+34 934 567 904',
        'pati@gmail.com'
    );

INSERT INTO
    glasses(
        supplierId,
        clientId,
        employeeId,
        glassBrand,
        glassRightLensGraduation,
        glassLeftLensGraduation,
        glassFrame,
        glassColorFrame,
        glassColorLens,
        glassPrice,
        glassSellingDate
    )
VALUES
    (
        2,
        1,
        1,
        'Armani',
        0.5,
        2.5,
        'Metallic',
        'blue',
        'grey',
        99.57,
        '2021-12-22'
    ),
    (
        1,
        1,
        1,
        ' Bimba',
        1.5,
        2.0,
        'Float',
        'red',
        'grey',
        55.23,
        '2021-12-12'
    ),
    (
        1,
        2,
        2,
        'Prada',
        0.75,
        2.5,
        'Pasta',
        'green',
        'grey',
        75.50,
        '2021-11-23'
    );

INSERT INTO
    addresses(
        supplierId,
        clientId,
        street,
        num,
        flat,
        door,
        city,
        postalCode,
        country
    )
VALUES
    (
        1,
        NULL,
        'Muntaner',
        '76',
        '5',
        '1',
        'Barcelona',
        '08020',
        'Spain'
    ),
    (
        2,
        NULL,
        'Aribau',
        '44',
        '2',
        '3',
        'Barcelona',
        '08020',
        'Spain'
    ),
    (
        NULL,
        1,
        'Meridiana',
        '55',
        '2',
        '1',
        'Barcelona',
        '08002',
        'Spain'
    ),
    (
        NULL,
        2,
        'Casanovas',
        '60',
        '4',
        '2',
        'Barcelona',
        '08390',
        'Spain'
    );

-- QUERIES

-- Qui ha sigut l’empleat que ha venut cada ullera i quan.

SELECT
    employeeName,
    glassSellingDate,
    glassBrand
FROM
    employees
    INNER JOIN glasses ON employees.employeeId = glasses.employeeId;

-- Total compres d'un client.

SELECT
    clientName
FROM
    clients
    INNER JOIN glasses ON clients.clientId = glasses.clientId
GROUP BY
    clients.clientId;

-- Llista les diferents ulleres que ha venut un empleat durant un any.

SELECT
    employeeName,
    glassBrand,
    glassSellingDate
FROM
    employees
    INNER JOIN glasses ON (
        employees.employeeId = glasses.employeeId
        AND glassSellingDate LIKE '2021%'
    );

-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit a la optica.

SELECT
    supplierName,
    glassBrand,
    glassSellingDate
FROM
    suppliers
    INNER JOIN glasses ON suppliers.supplierId = glasses.supplierId;