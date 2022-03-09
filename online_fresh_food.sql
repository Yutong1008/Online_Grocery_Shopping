-- One fresh store procides online service that customers can make orders to buy fruits, vegetables, herbs etc and book a delivery 

create database ofs;
-- A table to save all registered customers. One customers should have a unique id to identify. 
create table ofs_customers (
	id int not null Primary key,
    customername char(64) not null,
    address text not null,
    postcode int not null
);


-- A table to save all the products for sale on the website. 
-- Beside unique id and its display name, it should have a category id to let the website know how to display products in differnt categories in different levels

 create table ofs_category1_meta (
	id int not null primary key,
    displayname char(32) not null
);

create table ofs_category2_meta (
	id int not null primary key,
    cate1id integer not null,
    displayname char(32) not null,
    constraint fk_cate1 
    foreign key(cate1id) references ofs_category1_meta(id)
);

insert into ofs_categoryl_meta (id, displayname) values 
(1,'Fruit&Vegetables'),
(2, 'Bakery'),
(3, 'Milk&Diary');
insert into ofs_category2_meta (id, cate1id, displayname ) values
	(1, 1, 'Herbs'), 
	(2,1, 'Mashrooms'), 
	(3,1, 'Apples' ), 
	(4,1, 'Tomatoes'),
	(5, 2, 'Cookies'), 
	(6,2, ' Cakes '), 
	(7,2, 'Breads'),
	(8, 3, 'Cheese'),
	(9,3, 'Yoghurt'), 
	(10,3, 'Cream'), 
	(11,3, 'Milk');

create table ofs_products(
	id int not null primary key,
    name char(128) not null,
    categoryid integer not null,
    price numeric(8,2) not null,
    available int not null check(available >= 0),
    constraint fk_cate foreign key(categoryid) references ofs_category2_meta(id)
);
create table ofs_category_level (
level1_id int not null,
level2_id int not null,
level1_name char(128) not null,
level2_name char(128) not null,
primary key(level1_id, level2_id)
);

insert into ofs_category_level(level1_id, level2_id, level1_name, level2_name) value (
	(1,2,'a','b'),
	(1,3,'c','d')
);


-- Save all orders made by registed customers.  
create table ofs_orders(
	id int not null primary key,
    custid int not null,
    checkouttime timestamp not null,
    prodid int not null,
    prodquantity int not null check (prodquantity >= 1),
    prodprice numeric(8,2) not null check(prodprice >= 0.0),
    totalprice numeric(8,2) not null check(totalprice >= 0.0),
    address text not null,
    postcode int not null,
    deliveryid int,
    deleiverytime timestamp,
    constraint fk_cust foreign key(custid) references ofs_customer(id),
    constraint fk_prod foreign key(prodid) references ofs_product(id)
);


-- Save all scheduled delivery. Multiple orders are delivered in one scheduled delivery. 
-- All the chosen orders should have same delivery post code.
create table ofs_deliveries(
	id int not null primary key,
    createtime timestamp not null,
    finishtime timestamp,
    postcode int not null
);
-- datebase manipulation
-- place order
  Begin;
  insert into ofs_orders values(
  101,
  1,
  current_timestamp,
  100,
  2,
  1.99,
  3.98,
  '20 lucky rd',
  96108,
  null,
  null
  );

-- delievry scheduler program: used to update the new order id into those corresponding system
update ofs_orders set deliveryid = ? where id in (,,,) ;



