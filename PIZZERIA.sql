DROP DATABASE IF EXISTS pizzaMC;

CREATE DATABASE pizzaMC CHARACTER SET utf8mb4;

USE pizzaMC;

CREATE TABLE provinces(
    provinceId INT(5) NOT NULL AUTO_INCREMENT,
    provinceName VARCHAR(15),
    PRIMARY KEY (provinceId)
);

CREATE TABLE localities (
    localityId INT(5) NOT NULL AUTO_INCREMENT,
    localityName VARCHAR(15),
    provinceId INT(5),
    PRIMARY KEY (localityId),
    FOREIGN KEY (provinceId) REFERENCES provinces(provinceId)
);

CREATE TABLE clients (
    clientId INT(5) NOT NULL AUTO_INCREMENT,
    clientName VARCHAR(15) NOT NULL,
    clientLastName VARCHAR(15) NOT NULL,
    clientAddress VARCHAR(30),
    clientPostalCode INT(5),
    clientTelephone VARCHAR(15),
    localityId INT(5),
    PRIMARY KEY(clientId),
    FOREIGN KEY (localityId) REFERENCES localities(localityId)
);

CREATE TABLE shops (
    shopId INT(5) NOT NULL AUTO_INCREMENT,
    shopAddress VARCHAR(30),
    shopPostalCode VARCHAR(10),
    localityId INT(5),
    PRIMARY KEY(shopId),
    FOREIGN KEY (localityId) REFERENCES localities(localityId)
);

CREATE TABLE employees (
    employeeId INT(5) NOT NULL AUTO_INCREMENT,
    employeeName VARCHAR(30) NOT NULL,
    employeeLastName VARCHAR(30) NOT NULL,
    employeeNIF VARCHAR(9),
    employeeCellNumber VARCHAR(15),
    employeeCategory ENUM('Cook', 'Driver'),
    shopId INT(5),
    PRIMARY KEY(employeeId),
    FOREIGN KEY(shopId) REFERENCES shops(shopId)
);

CREATE TABLE products (
    productId INT(5) NOT NULL AUTO_INCREMENT,
    productOption ENUM('Pizza', 'burguer', 'drink'),
    productName VARCHAR(30) NOT NULL,
    productDescription VARCHAR(50),
    productImage BLOB,
    productPrice DECIMAL,
    PRIMARY KEY(productId)
);

CREATE TABLE pizzaCategory (
    pizzaCategoryId INT(5) NOT NULL AUTO_INCREMENT,
    categoryName VARCHAR(30) NOT NULL,
    productId INT(5),
    PRIMARY KEY(pizzaCategoryId),
    FOREIGN KEY (productId) REFERENCES products(productId)
);

CREATE TABLE orders (
    orderId INT(5) NOT NULL AUTO_INCREMENT,
    orderTime DATETIME,
    orderHow ENUM ('Delivery at Home', 'Pick up store'),
    orderAmount DECIMAL,
    clientId INT(5),
    shopId INT(5),
    employeeId INT(5),
    PRIMARY KEY (orderId),
    FOREIGN KEY (clientId) REFERENCES clients(clientId),
    FOREIGN KEY (shopId) REFERENCES shops(shopId),
    FOREIGN KEY (employeeId) REFERENCES employees(employeeId)
);

CREATE TABLE orderDelivery (
    orderDeliveryId INT(5) NOT NULL AUTO_INCREMENT,
    orderDeliveryTime DATETIME,
    employeeId INT(5),
    orderId INT(5),
    PRIMARY KEY(orderDeliveryId),
    FOREIGN KEY(employeeId) REFERENCES employees(employeeId),
    FOREIGN KEY (orderId) REFERENCES orders(orderId)
);

CREATE TABLE menuCalculator (
    menuCalculatorId INT(5) NOT NULL AUTO_INCREMENT,
    units INT(6),
    productId INT(5),
    orderId INT(5),
    PRIMARY KEY(menuCalculatorId),
    FOREIGN KEY(productId) REFERENCES products(productId),
    FOREIGN KEY(orderId) REFERENCES orders(orderId)
);

-- INSERT DATA

INSERT INTO
    provinces(provinceId, provinceName)
VALUES(1, 'Barcelona'),(2, 'Girona'),(3, 'Tarragona'),(4, 'Lleida'),
    (5, 'Murcia');

INSERT INTO
    localities(localityId, localityName, provinceId)
VALUES(1, 'Calella', 1),(2, 'Pineda', 1),(3, 'Cambrils', 3),(4, 'Borges', 4),(5, 'Cartagena', 5),(6, 'Pals', 2),(7, 'Roses', 2),(8, 'Calasparra', 5),(9, 'Mataro', 1),(10, 'Tarrega', 4);

INSERT INTO
    clients(
        clientId,
        clientName,
        clientLastName,
        clientAddress,
        clientPostalCode,
        clientTelephone,
        localityId
    )
VALUES
    (
        1,
        'Ana',
        'Peris',
        'Gran Via 23',
        '08370',
        '+34 665 778 999',
        1
    ),(
        2,
        'Bego',
        'Amat',
        'Muntaner 55',
        '43850',
        '+ 34 666 777 888',
        3
    ),
    (
        3,
        'Enric',
        'Mayne',
        'Animas 88',
        '30310',
        '+34 566 666 655',
        5
    ),
    (
        4,
        'Pol',
        'Var',
        'Aribau 55',
        '17480',
        '+34 555 666 222',
        7
    ),
    (
        5,
        'Bruce',
        'Bergan',
        'Balmes 34',
        '25300',
        '+34 111 222 333',
        10
    );

INSERT INTO
    shops (shopId, shopAddress, shopPostalCode, localityId)
VALUES
    (1, 'Rossello 22', '08370', 1),;

-- (ACABAR ENTRAR DATOS)

-- QUERIES:

-- 1.lista quants productes del tipus 'begudes' s'han venut en una determinada localitat

SELECT
    localityId,
    localityName
FROM
    localities
    INNER JOIN shops ON localities.localityId = shops.localityId
    INNER JOIN orders ON orders.shopId = shops.shopId
    INNER JOIN menucalculator ON menuCalculator.orderId = order.orderId
    INNER JOIN products
WHERE
    productOption IN('Drink') ON menucalculator.productId = products.productId
GROUP BY
    localityName;

-- 2.Llista quantes comandes ha efectuat un determinat empleat

SELECT
    employeeName,
    employeeLastname,
    employeeCategory,
FROM
    employees
    INNER JOIN orders ON orders.shopId = employees.shopId
GROUP BY
    employees.employeeId;