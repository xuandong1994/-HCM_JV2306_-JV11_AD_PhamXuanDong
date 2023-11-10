create database if not exists test;
use test;
create table categories(
 id int primary key auto_increment,
 name varchar(100) not null unique,
 status tinyint default 0
);
create table  products(
 id int primary key auto_increment,
 name varchar(200) not null,
 price float not null,
 sale_price float not null,
 image varchar(200),
 category_id int,
 foreign key (category_id) references categories(id)
);
create table customers(
 id int primary key auto_increment,
 name varchar(100) not null,
 email varchar(100) not null unique,
 image varchar(200),
 birthday date,
 gender tinyint
);
create table orders(
 id int primary key auto_increment,
 customer_id int,
 created timestamp default current_timestamp(),
 status tinyint default 0,
 foreign key (customer_id) references customers(id)
);
create table  order_details(
 order_id int,
 product_id int,
 quantity int not null,
 price  float not null,
 foreign key (order_id) references orders(id),
 foreign key (product_id) references products(id)
);

-- thêm dữ liệu 
insert into categories(name, status) value
('áo', 1),
('quần', 1),
('mũ', 1),
('giày', 1);

insert into  products(name, category_id, price, sale_price ) value
('áo sơ mi', 1, 150000, 149000 ),
('áo khoác dạ', 1, 500000, 499000),
('quần kaki ', 2, 200000,190000),
('Giầy tây', 4, 1000000,900000),
('mũ bảo hiểm a1', 3, 100000,90000);
insert into customers(name, email, birthday, gender ) value
('Nguyễn minh khôi', 'khoi@gmail.com', '2021-12-21',1),
('Nguyễn khánh linh', 'linh@gmail.com', '2001-12-12',0),
('đỗ khánh linh', 'linh2@gmail.com', '1999-01-01',0);
insert into orders (customer_id,created,status) value 
(1,'2023-11-08', 0),
(2,'2023-11-09', 0),
(1,'2023-11-09', 0),
(3,'2023-11-09', 0);
insert into  order_details(order_id, product_id, quantity, price ) value
(1,1,1,149000),
(1,2,1,499000),
(2,2,2,499000),
(3,2,1,499000),
(3,1,1,499000);

-- 1. Hiển thị danh sách danh mục gồm id,name,status (3đ).

select * from  categories;
-- 2. Hiển thị danh sách sản phẩm gồm id,name,price,sale_price,category_name(tên
-- danh mục) (7đ).

select p.id, p.name, p.price, p.sale_price from  products p join categories c on p.category_id = c.id;

-- 3. Hiển thị danh sách sản phẩm có giá lớn hơn 200000 (5đ).

select * from products p where p.price > 200000;

-- 4. Hiển thị 3 sản phẩm có giá cao nhất (5đ).

select * from products p 
where p.price order by price limit 3;

-- 5. Hiển thị danh sách đơn hàng gồm id,customer_name,created,status.(5đ)

select o.id, c.name customer_name , o.created, o.status  from  orders o join customers c on o.customer_id = c.id;

-- 6. Cập nhật trạng thái đơn hàng có id là 1(5đ)

update orders set status = 1 where id = 1;

-- 7. Hiển thị chi tiết đơn hàng của đơn hàng có id là 1, bao gồm
-- order_id,product_name,quantity,price,total_money là giá trị của (price * quantity) -- (10đ)

select od.order_id, p.name, od.quantity, od.price, sum(od.quantity * od.price) total_money
from order_details od join orders o on od.order_id = o.id
join  products p on od.product_id = p.id
where o.id = 1
group by od.order_id, p.name, od.quantity, od.price;

-- 8. Danh sách danh mục gồm, id,name, quantity_product(đếm trong bảng product) (20đ)

select c.id, c.name, count(p.id) quantity_product
 from categories c join products p on c.id = p.category_id 
 group by c.id, c.name;