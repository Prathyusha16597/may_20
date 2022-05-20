create table age_group(
age_group_id number(5) primary key,
age_min number(3),
age_max number(3),
age_range number(3));

insert all
into age_group values(10001,1,10,'Baby')
into age_group values(10002,11,39,'Young Adults' )
into age_group values(10003,40,59,'Middle age Adults')
into age_group values(10004,60,100,'Old Adults')
select * from dual;
commit;

create table country1(
country_id number(5) primary key,
country varchar(20));

insert all
into country1 values(20001,'india')
into country1 values(20002,'australia')
into country1 values(20003,'england')
into country1 values(20004,'america')
select * from dual;
commit;
create table region(
region_id number(5) primary key,
region varchar(20),
country_id number(5),
foreign key(country_id) references country1(country_id));

insert all
into region values(30001,'south india',20001)
into region values(30002,'victoria',20002)
into region values(30003,'north india',20001)
into region values(30004,'queensland',20002)
into region values(30005,'london',20003)
into region values(30006,'the plains',20004)
into region values(30007,'midlands',20003)
into region values(30008,'the mideast',20004)
select * from dual;
commit;

create table resort1(
resort_id number(5) primary key,
resort varchar(20),
country_id number(5),
foreign key(country_id) references country1(country_id));

insert all
into resort1 values(40001,'taj Club',20001)
into resort1 values(40002,'haven',20003)
into resort1 values(40003,'mahindra',20001)
into resort1 values(40004,'blue harbor',20004)
into resort1 values(40005,'rubens',20003)
into resort1 values(40006,'taj Metro',20001)
select * from dual;
commit;

create table city2(
city_id number(5) primary key,
city varchar(20),
region_id number(5),
foreign key(region_id) references region(region_id));

insert all
into city2 values(50001,'bangalore',30001)
into city2 values(50002,'hyderabad',30001)
into city2 values(50003,'kochi',30001)
into city2 values(50004,'delhi',30003)
into city2 values(50005,'madurai',30001)
into city2 values(50006,'jaipur',30003)
into city2 values(50007,'mysore',30001)
into city2 values(50008,'agra',30003)
into city2 values(50009,'chennai',30001)
select * from dual;
commit;

create table service_line(
sl_id number(5) primary key,
service_line number(3),
resort_id number(5),
foreign key(resort_id) references resort1(resort_id));

insert all
into service_line values(60001,102,40001)
into service_line values(60002,999,40002)
into service_line values(60003,103,40003)
into service_line values(60004,789,40004)
into service_line values(60005,107,40006)
select * from dual;
commit;

create table service(
service_id number(5) primary key,
service_name varchar(20),
price number(5),
sl_id number(5),
foreign key(sl_id) references service_line(sl_id));

insert all
into service values(70001,'buffet service',45000,60001)
into service values(70002,'self service',95000,60003)
into service values(70003,'buffet service',14520,60003)
into service values(70004,'waiter service',98752,60001)
into service values(70005,'self service',78542,60002)
into service values(70006,'chinese service',22245,60001)
into service values(70007,'waiter service',34569,60005)
into service values(70008,'no service',74585,60003)
select * from dual;
commit;


create table customer6(
cust_id number(5) primary key,
first_name varchar(10),
last_name varchar(10),
phone_no number(10),
address varchar(20),
age_group_id number(5),
city_id number(5));
---foreign key(age_group_id) references age_group(age_group_id),
--foreign key(city_id) references city2(city_id));

insert all
into customer6 values(80001,'tim','stan',9887410256,'jayanagar',10001,50001)
into customer6 values(80002,'clark','kent',9887410356,'mysore zoo',10002,50007)
into customer6 values(80003,'bill','bucky',9887410456,'jp nagar',10003,50001)
into customer6 values(80004,'peter','parker',9887400256,'charminar',10004,50002)
into customer6 values(80005,'bruce','wayne',9887490256,'dilli haat',10005,50004)
into customer6 values(80006,'barry','allen',9887260256,'jew town',10006,50003)
into customer6 values(80007,'hal','jordon',9887470256,'marina beach',10007,50009)
into customer6 values(80008,'diana','prince',9888810256,'meenakshi temple',10008,50005)
into customer6 values(80009,'tony','stark',9887987256,'hawa mahal',10003,50006)
select * from dual;
commit;

create table reservation1(
res_id number(5) primary key,
res_date date,
cust_id number(5));
--foreign key(cust_id) references customer5(cust_id));

insert all
into reservation1 values(90001,'19-may-2022',80005)
into reservation1 values(90002,'25-jun-2020',80006)
into reservation1 values(90003,'16-apr-2021',80007)
into reservation1 values(90004,'8-jan-2016',80001)
into reservation1 values(90005,'7-feb-2018',80002)
into reservation1 values(90006,'30-aug-2019',80009)
select * from dual;
commit;

create table reservation_line(
future_guests number(3),
res_days number(3),
res_id number(5),
service_id number(5));
--foreign key(res_id) references reservation(res_id),
--foreign key(service_id) references service(service_id));

insert all
into reservation_line values(110,20,90002,70001)
into reservation_line values(200,15,90005,70006)
into reservation_line values(20,17,90006,70002)
into reservation_line values(300,18,90001,70008)
into reservation_line values(250,30,90004,70004)
select * from dual;

commit;
select * from customer6;
------Find out the resorts where both customer Tim and customer Bill stayed;
select resort
from (select resort from resort1 r1,city2 c2,region r,country1 c1,customer6 C
where C.city_id=c2.city_id and c2.region_id=r.region_id and r.country_id=c1.country_id and c1.country_id=r1.country_id and
first_name='tim')intersect
(select resort from resort1 r1,city2 c2,region r,country1 c1,customer6 C
where C.city_id=c2.city_id and c2.region_id=r.region_id and r.country_id=c1.country_id and c1.country_id=r1.country_id and
 first_name='bill');
select resort
from resort1 r1,city2 c2,region r,country1 c1,customer6 C
where C.city_id=c2.city_id and c2.region_id=r.region_id and r.country_id=c1.country_id and c1.country_id=r1.country_id and first_name in(select first_name
from customer6 
where first_name='tim')and first_name in (select first_name
from customer6
where first_name='bill');
select * from customer6;
select * from city2;
select * from region;
select * from country1;
select * from resort1;
select * from service;
insert into resort1 values(40007,'fordyce',20001);
commit;

----Find out the services which are available in the resort Taj Club but not in Taj Metro;
select service_name
from(select service_name from service s,service_line sl,resort1 r
where s.sl_id=sl.sl_id and sl.resort_id=r.resort_id
and resort = 'taj Club')minus
(select service_name from service s,service_line sl,resort1 r
where s.sl_id=sl.sl_id and sl.resort_id=r.resort_id and resort='taj Metro');
insert into service values(70009,'buffet service',34000,60005);
commit;
-----Display customer name, age group, city, region and country who has reserved �Boat services�

select cu.first_name||last_name,cu.age_group_id,c.city,rg.region,ct.country,service_name
from customer6 cu,reservation1 r,reservation_line rl,service s,city2 c,region rg,country1 ct
where cu.cust_id=r.cust_id
and r.res_id=rl.res_id
and rl.service_id=s.service_id
and cu.city_id=c.city_id
and c.region_id=rg.region_id
and rg.country_id=ct.country_id
and s.service_name='buffet service';
select * from service;

select * from service;
select * from customer6;
----Display the regions where we have more than 2 cities;
select region_id,count(city_id)
from city2
group by region_id
having count(city_id)>2;
---- Display age group wise customer count;
select count(c.cust_id),ag.age_group_id
from customer6  c,age_group ag
where c.age_group_id =ag.age_group_id
group by ag.age_group_id;
----What is the costliest service in each service_line? Display the result which displays service_name, price, maximum_price with in the service line;
select a.service_name,a.price,a.service_line
from (select sl.sl_id,service_line,service_name,price,dense_rank() over(partition by service_line order by price desc)rnk
                 from service s, service_line sl
                 where s.sl_id=sl.sl_id)a
where a.rnk=1;
-------Display country_name, number of regions and number of cities for each country;
select nvl(cr.country,0)as country,nvl(no_of_region,0)as no_of_region,nvl(no_of_city,0)as no_of_city
from (select ct.country ,count(r.region_id)as no_of_region
from region r, country1 ct
where r.country_id=ct.country_id
group by country)cr ,
(select ct.country ,count(c.city_id)as no_of_city
from city2 c,region r, country1 ct
where c.region_id=r.region_id
and r.country_id=ct.country_id
group by country)cc
where cr.country=cc.country(+);

select * from country1;
select * from region;
select * from city2;

---Display the number of reservations we have basedon each resort
select count(r.res_id),re.resort_id
from reservation1 r,reservation_line rl,service s,service_line sl,resort1 re
where r.res_id=rl.res_id and rl.service_id=s.service_id
and s.sl_id=sl.sl_id and sl.resort_id=re.resort_id
group by re.resort_id;
select * from  reservation1;
select * from reservation_line;
select * from customer6;
