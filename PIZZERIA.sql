DROP DATABASE IF EXISTS pizza2;

CREATE DATABASE pizza2 CHARACTER SET utf8mb4;

USE pizza2;

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
    clientCellNumber VARCHAR(20),
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
    employeeCellNumber VARCHAR(20),
    employeeCategory ENUM('Cook', 'Driver'),
    shopId INT(5),
    PRIMARY KEY(employeeId),
    FOREIGN KEY(shopId) REFERENCES shops(shopId)
);

CREATE TABLE products (
    productId INT(5) NOT NULL AUTO_INCREMENT,
    productOption ENUM('Pizza', 'Burguer', 'Drink'),
    productName VARCHAR(30) NOT NULL,
    productDescription VARCHAR(50),
    productImage BLOB,
    productPrice DECIMAL(64),
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
    orderHow ENUM ('Delivery at Home', 'Pick up Store'),
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
        clientCellNumber,
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
    (1, 'Rossello 22', '08370', 1),
    (2, 'Bruguera 34', '43850', 3),
    (3, 'Rambla 2', '30310', 5),
    (4, 'Sant Pere 6', '17480', 7),
    (5, 'Balmes 5', '25300', 10);

INSERT INTO
    employees (
        employeeId,
        employeeName,
        employeeLastName,
        employeeNIF,
        employeeCellNumber,
        employeeCategory,
        shopId
    )
VALUES
    (
        1,
        'Name1',
        'Surname1',
        '35113958L',
        '+34 444 555 666',
        'Cook',
        1
    ),
    (
        2,
        'Name2',
        'Surname2',
        '34666888M',
        '+34 666 333 333',
        'Cook',
        2
    ),
    (
        3,
        'Name3',
        'Surname3',
        '55666777N',
        '+34 555 222 111',
        'Driver',
        3
    ),
    (
        4,
        'Name4',
        'Surname4',
        '56777899B',
        '+34 555 111 666',
        'Cook',
        4
    ),
    (
        5,
        'Name5',
        'Surname5',
        '66777899L',
        '+34 666 222 222',
        'Driver',
        5
    );

INSERT INTO
    products (
        productId,
        productOption,
        productName,
        productDescription,
        productImage,
        productPrice
    )
VALUES
    (
        1,
        'Drink',
        'Fanta',
        'Orange flavoor',
        LOAD_FILE('d:/sample.png'),
        3.45
    ),
    (
        2,
        'Drink',
        'Cocacola',
        'Sugar free',
        LOAD_FILE('d:/sample2.png'),
        2.55
    ),
    (
        3,
        'Burguer',
        'Burguer vegan',
        'onion',
        LOAD_FILE('d:/sample3.png'),
        3.20
    ),
    (
        4,
        'Drink',
        'water',
        'sparkling',
        LOAD_FILE('d:/sample4.png'),
        1.32
    ),
    (
        5,
        'Pizza',
        'Pizza Manola',
        'Vegan type',
        LOAD_FILE('d:/sample5.png'),
        10.56
    ),
    (
        6,
        'Pizza',
        'Pizza White',
        'Without tomato',
        LOAD_FILE('d:/sample6.png'),
        12.68
    );

INSERT INTO
    pizzaCategory (pizzaCategoryId, categoryName, productId)
VALUES
    (1, 'VEGAN', 5),
    (2, 'NO TOMATO', 6);

INSERT INTO
    orders (
        orderId,
        orderTime,
        orderHow,
        orderAmount,
        clientId,
        shopId,
        employeeId
    )
VALUES
    (
        1,
        '2020-04-03 20:05:00',
        'Delivery at Home',
        45.66,
        1,
        1,
        1
    ),
    (
        2,
        '2020-04-01 20:30:01',
        'Delivery at Home',
        66.78,
        2,
        2,
        2
    ),
    (
        3,
        '2020-03-02 21:34:03',
        'Delivery at Home',
        90.56,
        3,
        3,
        3
    ),
    (
        4,
        '2020-03-02 21:55:00',
        'Pick up Store',
        180.44,
        4,
        4,
        4
    ),
    (
        5,
        '2020-01-01 21:44:00',
        'Pick up Store',
        34.66,
        5,
        5,
        5
    );

INSERT INTO
    orderDelivery(
        orderDeliveryId,
        orderDeliveryTime,
        employeeId,
        orderId
    )
VALUES
    (1, '2020-04-01 20:30:01', 1, 1),
    (2, '2020-04-01 20:30:01', 2, 2),
    (3, '2020-03-02 21:34:03', 3, 3);

INSERT INTO
    menuCalculator (menuCalculatorId, units, productId, orderId)
VALUES
    (1, 3, 1, 1),
    (2, 4, 4, 1),
    (3, 2, 2, 2),
    (4, 2, 5, 2),
    (5, 5, 4, 2),
    (6, 5, 1, 3),
    (7, 2, 2, 3),
    (8, 3, 1, 4),
    (9, 2, 2, 4),
    (10, 3, 6, 4),
    (11, 3, 2, 5),
    (12, 2, 3, 5);

-- QUERIES:

-- 1.lista quants productes del tipus 'begudes' s'han venut en una determinada localitat

SELECT
    localityName,
    productOption,
    units
FROM
    localities
    INNER JOIN shops ON localities.localityId = shops.localityId
    INNER JOIN orders ON orders.shopId = shops.shopId
    INNER JOIN menucalculator ON menuCalculator.orderId = orders.orderId
    INNER JOIN products ON menucalculator.productId = products.productId
WHERE
    productOption IN('Drink')
GROUP BY
    localityName;

-- 2.Llista quantes comandes ha efectuat un determinat empleat

SELECT
    employeeName,
    employeeLastname,
    employeeCategory,
    COUNT(orderId)
FROM
    employees
    INNER JOIN orders ON orders.shopId = employees.shopId
GROUP BY
    employees.employeeId;