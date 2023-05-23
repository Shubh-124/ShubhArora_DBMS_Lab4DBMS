CREATE database ECOMMERCE;
CREATE TABLE SUPPLIER(
     SUPP_ID INT unsigned PRIMARY KEY auto_increment, 
     SUPP_NAME VARCHAR(50) NOT NULL, 
     SUPP_CITY VARCHAR(50) NOT NULL, 
     SUPP_PHONE VARCHAR(50) NOT NULL
  );
SELECT * FROM SUPPLIER;
CREATE TABLE CUSTOMER(
     CUS_ID INT unsigned PRIMARY KEY auto_increment, 
     CUS_NAME VARCHAR(20) NOT NULL, 
     CUS_PHONE VARCHAR(10) NOT NULL, 
     CUS_CITY VARCHAR(30) NOT NULL,
     CUS_GENDER enum('M','F') NOT NULL
  );
  SELECT * FROM CUSTOMER; 
  
  CREATE TABLE CATEGORY(
  CAT_ID INT unsigned PRIMARY KEY auto_increment,
  CAT_NAME VARCHAR(20) NOT NULL
  );
  SELECT * FROM CATEGORY; 
  
  CREATE TABLE PRODUCT(
  PRO_ID INT unsigned PRIMARY KEY auto_increment, 
  PRO_NAME VARCHAR(20) NOT NULL, 
  PRO_DESC VARCHAR(60), 
  CAT_ID INT UNSIGNED, 
  FOREIGN KEY(CAT_ID) REFERENCES CATEGORY(CAT_ID)
  );
  SELECT * FROM PRODUCT;
 
 CREATE table SUPPLIER_PRICING (
	PRICING_ID int unsigned primary key AUTO_INCREMENT,
    PRO_ID int unsigned, foreign key(PRO_ID) references product(PRO_ID),
    SUPP_ID int unsigned, foreign key(SUPP_ID) references supplier(SUPP_ID),
    SUPP_PRICE int default 0
);
SELECT * FROM SUPPLIER_PRICING;

CREATE TABLE ORDERS(ORD_ID INT unsigned PRIMARY KEY auto_increment,
ORD_AMOUNT INT unsigned NOT NULL,
ORD_DATE DATE NOT NULL,
CUS_ID INT unsigned, FOREIGN KEY(CUS_ID) 
REFERENCES CUSTOMER(CUS_ID),
PRICING_ID INT unsigned, FOREIGN KEY(PRICING_ID) 
REFERENCES SUPPLIER_PRICING(PRICING_ID)
); 
SELECT * FROM ORDERS;

CREATE TABLE RATING(
RAT_ID INT unsigned PRIMARY KEY auto_increment,
ORD_ID INT unsigned, FOREIGN KEY(ORD_ID) REFERENCES ORDERS(ORD_ID),
RAT_RATSTARS INT unsigned
);
SELECT * FROM  RATING;

INSERT INTO SUPPLIER VALUES 
(1, "Rajesh Retails","Delhi","1234567890"),
(2,"Appario Ltd.","Mumbai","2589631470"),
(3,"Knome products","Banglore","9785462315"),
(4,"Bansal Retails","Kochi","8975463285"),
(5,"Mittal Ltd.","Lucknow","7898456532");

SELECT * FROM SUPPLIER;

INSERT INTO CUSTOMER VALUES 
(1, "AAKASH","9999999999","DELHI",'M'),
(2,"AMAN","9785463215","NOIDA",'M'),
(3,"NEHA","9999999999","MUMBAI",'F'),
(4,"MEGHA","9994562399","KOLKATA",'F'),
(5,"PULKIT","7895999999","LUCKNOW",'M');
SELECT * FROM CUSTOMER;

INSERT INTO CATEGORY VALUES 
(1, "BOOKS"),
(2,"GAMES"),
(3,"GROCERIES"),
(4,"ELECTRONICS"),
(5,"CLOTHES");
SELECT * FROM CATEGORY;

INSERT INTO PRODUCT VALUES 
(1, "GTA V","Windows 7 and above with i5 processor and 8GB RAM",2),
(2,"TSHIRT","SIZE-L with Black, Blue and White variations",5),
(3,"ROG LAPTOP	","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4),
(4,"OATS","Highly Nutritious from Nestle",3),
(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1),
(6,"MILK","1L Toned Milk",3),
(7,"Boat Earphones","1.5Meter long Dolby Atmos",4),
(8,"Jeans","Stretchable Denim Jeans with various sizes and color",5),
(9,"Project IGI","compatible with windows 7 and above",2),
(10,"Hoodie","Black GUCCI for 13 yrs and above",5),
(11,"Rich Dad Poor Dad","Written by RObert Kiyosaki",1),
(12,"Train Your Brain","By Shireen Stephen",1);

SELECT * FROM PRODUCT;

INSERT INTO SUPPLIER_PRICING VALUES
(1,1,2,1500),
(2,3,5,30000),
(3,5,1,3000),
(4,2,3,2500),
(5,4,1,1000), 
(6,6,2,1000),
(7,8,5,20000),
(8,9,4,50000),
(9,7,3,10000),
(10,10,3,20000),
(11,11,4,30000),
(12,1,2,30000),
(13,12,4,40000),
(14,4,5,7000);
SELECT * FROM SUPPLIER_PRICING;

INSERT INTO ORDERS VALUES 
(101,1500,'2021-10-06',2,1),
(102,1000,'2021-10-12',3,5),
(103,30000,'2021-09-16',5,2),
(104,1500,'2021-10-05',1,1),
(105,3000,'2021-08-16',4,3),
(106,1450,'2021-08-18',1,9),
(107,789,'2021-09-01',3,7),
(108,780,'2021-09-07',5,6),
(109,3000,'2021-01-10',5,3),
(110,2500,'2021-09-10',2,4),
(111,1000,'2021-09-15',4,5),
(112,789,'2021-09-16',4,7),
(113,31000,'2021-09-16',1,8),
(114,1000,'2021-09-16',3,5),
(115,3000,'2021-09-16',5,3),
(116,99,'2021-09-17',2,14);
SELECT * FROM ORDERS;

INSERT INTO RATING VALUES
(1,101,4),
(2,102,3),
(3,103,1),
(4,104,2),
(5,105,4),
(6,106,3),
(7,107,4),
(8,108,4),
(9,109,3),
(10,110,5),
(11,111,3),
(12,112,4),
(13,113,2),
(14,114,1),
(15,115,1),
(16,116,0);

SELECT * FROM RATING;

-- Query 1
select customer.CUS_GENDER as Gender,count(customer.CUS_GENDER) as "No. of Customers"  from orders inner join customer on orders.cus_id=customer.CUS_ID 
where ORD_AMOUNT>=3000 group by customer.CUS_GENDER;

-- Query 2
select ord_id,pro_name,ord_amount,ord_date,SUPP_PRICE from orders inner join supplier_pricing on orders.PRICING_ID=supplier_pricing.pricing_id inner join product 
on supplier_pricing.PRO_ID=product.PRO_ID
 where cus_id=2;