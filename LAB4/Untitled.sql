show databases;
create database E_commerce;
use E_commerce;

create table supplier(
SUPP_ID int primary key,SUPP_NAME varchar(50) not null ,SUPP_CITY varchar(50) not null,SUPP_PHONE varchar(50) not null);

create table customer(
CUS_ID int primary key,CUS_NAME varchar(20) not null ,CUS_PHONE varchar(10) not null ,CUS_CITY varchar(30) not null ,CUS_GENDER char);

create table category(
CAT_ID int primary key,CAT_NAME varchar(20) not null );

create table product(
PRO_ID int primary key,PRO_NAME varchar(20) Not null default "Dummy",PRO_DESC varchar(60),CAT_ID int,Foreign Key(CAT_ID) REFERENCES category(CAT_ID));


create table supplier_pricing(
PRICING_ID int primary key,PRO_ID int,SUPP_ID int,SUPP_PRICE int default 0, Foreign Key(PRO_ID) REFERENCES product(PRO_ID) 
,Foreign Key(SUPP_ID) REFERENCES supplier(SUPP_ID) );

create table order_table(
ORD_ID int primary key,ORD_AMOUNT int Not null,ORD_DATE date,CUS_ID int,PRICING_ID int,Foreign Key(CUS_ID) REFERENCES customer(CUS_ID),
Foreign Key(PRICING_ID) REFERENCES supplier_pricing(PRICING_ID));

create table rating(
RAT_ID int primary key,ORD_ID int,RAT_RATSTARS int not null,Foreign Key(ORD_ID) REFERENCES order_table(ORD_ID));

Insert into supplier values(1,"Rajesh Retails",	"Delhi", "1234567890"),
(2,"Appario Ltd.",	"Mumbai", "2589631470"),
(3,"Knome products",	"Banglore", "9785462315"),
(4,"Bansal Retails	",	"Kochi", "8975463285"),
(5,"Mittal Ltd.",	"Lucknow", "7898456532");

Insert into customer values(1,"AAKASH"	,"9999999999",	"DELHI",'M'),
(2,"AMAN"	,"9785463215",	"NOIDA",'M'),
(3,"NEHA"	,"9999999999",	"MUMBAI",'F'),
(4,"MEGHA"	,"9994562399",	"KOLKATA",'F'),
(5,"PULKIT"	,"7895999999",	"LUCKNOW",'M');

Insert into category values(1,"BOOKS"),
(2,"GAMES"),
(3,"GROCERIES"),
(4,"ELECTRONICS"),
(5,"CLOTHES");

insert into product values(1,"GTA V	","Windows 7 and above with i5 processor and 8GB RAM",2),
(2,	"TSHIRT",		"SIZE-L with Black, Blue and White variations",5),
(3		,"ROG LAPTOP"	,	"Windows 10 with 15inch screen, i7 processor, 1TB SSD",4),
(4,"OATS","Highly Nutritious from Nestle",3),
(5,"HARRY POTTER",	"Best Collection of all time by J.K Rowling",1),
(6,"MILK"	,"1L Toned MIlk",3),
(7,"Boat Earphones"	,"1.5Meter long Dolby Atmos",4),
(8,"Jeans"	,"Stretchable Denim Jeans with various sizes and color",5),
(9,"Project IGI",	"compatible with windows 7 and above",2),
(10,"Hoodie","Black GUCCI for 13 yrs and above",5),
(11,"Rich Dad Poor Dad",	"Written by RObert Kiyosaki",1),
(12,"Train Your Brain","By Shireen Stephen",1);

insert into supplier_pricing values(1,1,2,1500),
(2,3,5,30000),
(3,5,1,3000),
(4,2,3,2500),
(5,4,1,1000);

insert into order_table values(101,1500,'2021-10-06',2,1),
(102,1000,'2021-10-12',3,5),
(103,30000,'2021-09-16',5,2),
(104,1500,'2021-10-05',1,1),
(105,3000,'2021-08-16',4,3),
(109,3000,'2021-08-10',5,3),
(110,2500,'2021-09-10',2,4),
(111,1000,'2021-09-15',4,5),
(114,1000,'2021-09-16',3,5),
(115,3000,'2021-09-16',5,3);

insert into rating values(1,101,4),
(2,102,3),
(3,103,1),
(4,104,2),
(5,105,4),
(9,109,3),
(10,110,5),
(11,111,3),
(14,114,1),
(15,115,1);

Select Count(CUS_GENDER) from customer c inner join order_table  o on c.CUS_ID = o.CUS_ID where o.ORD_AMOUNT>=3000 group by c.CUS_GENDER;

Select * from product p inner join 
(Select o.ord_id,o.ord_amount,o.ord_date,o.cus_id,sp.pro_id from order_table o inner join supplier_pricing sp on o.pricing_id=sp.pricing_id where o.cus_id=2)
 t on p.pro_id=t.pro_id;
 
 Select * from supplier s inner join (Select supp_id, count(Supp_id) from supplier_pricing group by supp_id having count(supp_id)>=2) sp 
 on s.supp_id =sp.supp_id ;
 
 Select tbl.pro_id,tbl.pro_name,c.cat_id,c.cat_name,tbl.supp_price from category c inner join (Select p.pro_id,p.pro_name,p.cat_id,t.supp_price from product p inner join (
Select Pro_id,supp_price from supplier_pricing where supp_price in (
 Select MIN(Supp_price)  from product p inner join supplier_pricing sp on p.pro_id = sp.pro_id group by CAT_ID)
 ) t on p.pro_id=t.pro_id) 
 tbl on c.cat_id=tbl.cat_id;
 
 
 
 Select p.pro_id, pro_name from product p inner join (
 Select o.ord_date,sp.pricing_id,sp.pro_id from order_table o inner join supplier_pricing sp on o.pricing_id= sp.pricing_id where ord_date>'2021-10-05') 
 t on p.pro_id=t.pro_id;
 
 Select * from customer where cus_name like 'A%' or cus_name like '%A';
 

Select s.supp_id,s.supp_name,
Case 
when tbl.RAT_RATSTARS=5 then "Excellent"
When tbl.RAT_RATSTARS>4 then "Good Service"
when tbl.RAT_RATSTARS>2 then "Average Service"
else "Poor Service"
End as type_of_service
 from supplier s inner join 
(Select sp.pricing_id,sp.supp_id,t.RAT_RATSTARS from supplier_pricing sp inner join (
Select r.ord_id,r.RAT_RATSTARS,o.pricing_id from rating r inner join order_table o on r.ord_id=o.ord_id) t 
on sp.pricing_id=t.pricing_id) tbl

on s.supp_id-tbl.supp_id
















