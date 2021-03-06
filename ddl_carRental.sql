drop database car_rental_management;
create database car_rental_management;

\c car_rental_management

create table customer ( 
customer_id int NOT NULL,
mobile_number char(12) NOT NULL,
licence_number char(12) NOT NULL,
customer_address varchar NOT NULL,

Primary key(customer_id)
);

create table outlet ( 
outlet_id int NOT NULL,
outlet_name varchar NOT NULL,
outlet_location varchar NOT NULL,

outlet_savings int NOT NULL,

Primary key(outlet_id)
);

create table employee(
    employee_id int NOT NULL,
    employee_name varchar NOT NULL,
    employee_mobile_number char(12) NOT NULL,   --Needed or not ?
    employee_salary int NOT NULL,   --Needed or not ?
    outlet_id int NOT NULL,

    Primary key(employee_id),
    Foreign key(outlet_id) references outlet(outlet_id) on delete restrict
);


create table vehicle( 
plate_number CHAR(20) NOT NULL,
outlet_id int NOT NULL,
model varchar NOT NULL,
number_of_seats int NOT NULL,
ac boolean NOT NULL,
vehicleStatus varchar NOT NULL,

Primary key(plate_number),
Foreign key(outlet_id) references outlet(outlet_id) on delete restrict
);



create table reservation ( 
reservation_id int NOT NULL,
reservation_date DATE NOT NULL,
vehicle_taken_date DATE NOT NULL,
expected_return_date DATE NOT NULL,
customer_id int NOT NULL default -1,
outlet_id int NOT NULL,
advance int default 1000,
emp_id int NOT NULL default -1,

plt_num CHAR(20) NOT NULL default 'car sold/no more',

reservation_status CHAR(20) NOT NULL,   -- for reservation status

Primary key(reservation_id),
Foreign key(customer_id) references customer(customer_id) on delete set default,
Foreign key(outlet_id) references outlet(outlet_id)  on delete restrict,
Foreign key(plt_num) references vehicle(plate_number) on update cascade on delete set default ,
Foreign key(emp_id) references employee(employee_id) on delete set default
);



create table rent(
bill_id SERIAL NOT NULL,
taken_date DATE NOT NULL,
return_date DATE NOT NULL,
number_of_days int NOT NULL,     -- taken_date-return_date,
tax_amount int NOT NULL default 10,
total_amount int ,
customer_id int NOT NULL,
reservation_id int NOT NULL UNIQUE default -1,
refund int NOT NULL,
plt_num CHAR(20) NOT NULL default 'car sold/no more',

Primary key(bill_id),
Foreign key(customer_id) references customer(customer_id) on delete set default,
Foreign key(reservation_id) references reservation(reservation_id)  on delete restrict,
Foreign key(plt_num) references vehicle(plate_number) on update cascade on delete set default
);



create table discount(
promo_id char(30) NOT NULL,
discount_amount int NOT NULL,
startdate DATE NOT NULL,
enddate DATE NOT NULL,

Primary key(promo_id)

);

create table outlet_contact(
outlet_id int NOT NULL,
outlet_phone char(12) NOT NULL,
outlet_mail varchar(55),

Primary key(outlet_id,outlet_phone),
Foreign key(outlet_id) references outlet(outlet_id) on delete cascade
);


create table got_discount(
    disc_id char(30) NOT NULL default 'promo discontinued',
    bill_id int NOT NULL,

    Primary Key(disc_id,bill_id),
    Foreign key(disc_id) references discount(promo_id) on delete set default
);


