


USE orders;
go;
DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;

CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO category(categoryName) VALUES ('Nike');
INSERT INTO category(categoryName) VALUES ('Off-White');
INSERT INTO category(categoryName) VALUES ('Adidas');
INSERT INTO category(categoryName) VALUES ('Gucci');
INSERT INTO category(categoryName) VALUES ('Payless');
INSERT INTO category(categoryName) VALUES ('Vans');
INSERT INTO category(categoryName) VALUES ('Dior');
INSERT INTO category(categoryName) VALUES ('Prada');


INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Nike Air Force 1- 07',1,'the basketball original from 07, classic',145.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Nike Air Jordan 1 Retro High OG',1,'Original Retro Air Jordan Highs',225.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Nike Panda Low dunks', 1, '2021 Nike Dunk Low Retro White Black Pandas (2021) (GS)',210.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Nike Blazer High Vintage',1,'Styled for the 70s',140.00);

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Out Of Office 0oo Sneakers',2,'Out Of Office sneakers with For Walking text and white arrow',635.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Out Of Office(Red)',2,'Classic Out Of Office Off-White shoes with red colour',635.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Out Of Office For Walking Sneakers',2,'Off White Out Of Office with For Walking Design',635.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Out Of Office Full Suede',2,'Out Of Office in blue and white and full suede',635.00);

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Adidas Ultraboost 22',3,'Core Black shoes with ultraboost shoe design',250.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Adidas Star Wars x NMD_R1 Darth Vader',3,'Star wars collab with Adidas',254.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Adidas NMD_R1 Triple Black',3,'Triple Black NMD_R1 varient',97.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Adidas Forum Low White Royal Blue',3,'Royal blue coloured low forum sneakers',67.00);

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gucci Tennis 1977 Ebony',4,'Gucci Tennis shoes',769.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gucci Wmns Ace Embroidered Bee',4,'Gucci shoes with bee on logo',972.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gucci GG Supreme Low Beige Blue',4,'Beige gucci shoes',595.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gucci Ace Leather White',4,'White Leather gucci shoes',394.00);

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Payless Airwalk',5,'Airwalk Legacee Sneaker',29.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Payless Cross Trekkers',5,'Cross Trekkers Mix Up',19.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Payless LA Gear',5,'LA Gear Dash Court Sneaker',29.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Payless Airwalk Highs',5,'Airwalk Boardslide High Top Skate Sneaker',37.49);

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Vans Canvas Old Skool',6,'Old Skool design from vans',90.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Vans Slip On',6,'Vans slip on Shoes',75.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Vans Sk8-Hi Shoe',6,'Vans high tops',100.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Vans x Thrasher Skate Old Skool Shoe',6,'Vans x thrasher collab in old skool type shoe',89.00);

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dior B23 High-Top Sneaker, ',7,'Dior B23 style High top sneaker',1450.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dior B27 Low top sneaker',7,'Dior B27 style low top sneaker',1450.00);

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Prada Blue Downtown Leather Sneakers',8,'Downtown leather sneakers(blue)',1370.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Prada Brushed Leather Sneakers',8,'Brushed Leather Sneakers',1120.00);


INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'shoes/airForce1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'shoes/Jordan1.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'shoes/nikePanda.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'shoes/nikeBlazers.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'shoes/offwhite1.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'shoes/offwhite2.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'shoes/offwhite3.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'shoes/offwhite4.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'shoes/adidasUB22.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'shoes/adidas2.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'shoes/adidas3.jpg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'shoes/adidas4.jpg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'shoes/gucci1.jpg' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'shoes/gucci2.jpg' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'shoes/gucci3.jpg' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'shoes/gucci4.jpg' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'shoes/pl1.jpg' WHERE ProductId = 17;
UPDATE Product SET productImageURL = 'shoes/pl2.jpg' WHERE ProductId = 18;
UPDATE Product SET productImageURL = 'shoes/pl3.jpg' WHERE ProductId = 19;
UPDATE Product SET productImageURL = 'shoes/pl4.jpg' WHERE ProductId = 20;
UPDATE Product SET productImageURL = 'shoes/vans1.jpg' WHERE ProductId = 21;
UPDATE Product SET productImageURL = 'shoes/van2.jpg' WHERE ProductId = 22;
UPDATE Product SET productImageURL = 'shoes/van3.jpg' WHERE ProductId = 23;
UPDATE Product SET productImageURL = 'shoes/van4.jpg' WHERE ProductId = 24;
UPDATE Product SET productImageURL = 'shoes/d1.jpg' WHERE ProductId = 25;
UPDATE Product SET productImageURL = 'shoes/d2.jpg' WHERE ProductId = 26;
UPDATE Product SET productImageURL = 'shoes/prada1.jpg' WHERE ProductId = 27;
UPDATE Product SET productImageURL = 'shoes/prada2.jpg' WHERE ProductId = 28;


