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