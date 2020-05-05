create database db_1BM18CS037;
use db_1BM18CS037;
create table person
( driver_id varchar(20),
  name varchar(20),
  address varchar(30),
  primary key(driver_id)
  );
  show databases;
create table car
  (reg_num varchar(20),
    model varchar(20),
    year int,
    primary key(reg_num)
    );
create table accident
    (report_num varchar(20),
      accident date,
      location varchar(20),
      primary key (report_num)
      );
      
      
 create table owns
      (driver_id varchar(20),
       reg_num varchar(20),
       primary key(driver_id,reg_num),
       foreign key(driver_id)references person(driver_id),
       foreign key(reg_num)references car(reg_num)
       );
  create table participated
       (driver_id varchar(20),
		reg_num varchar(20),
        report_num varchar(20),
        damage_amount int,
        primary key(driver_id,reg_num,report_num),
        foreign key(driver_id)references person(driver_id),
        foreign key(reg_num)references car(reg_num),
        foreign key(report_num)references accident(report_num)
        );
 insert into person values("A01","Richard","srinivas nagar");
 insert into person values("A02","Pradeep","rajaji nagar");
 insert into person values("A03","Smith","ashok nagar");
 insert into person values("A04","VENU","N R colony");
 insert into person values("A05","John","Hanumanth nagar");
         select * from person;
 insert into car values("KA052250","indica","1990");
 insert into car values("KA031181","lancer","1957");
 insert into car values("KA095477","toyota","1998");
 insert into car values("KA053408","honda","2008");
 insert into car values("KA041702","audi","2005");
           select * from car;
 insert into owns values("A01","KA052250");     
 insert into owns values("A02","KA053408");
 insert into owns values("A03","KA031181");
 insert into owns values("A04","KA095477");
 insert into owns values("A05","KA041702");
   select * from owns;
 insert into accident values("11","2003-01-01","MYSORE ROAD");   
 insert into accident values("12","2004-02-02","SOUTH END CIRCLE"); 
 insert into accident values("13","2003-01-21","BULLTEMPLE ROAD");    
 insert into accident values("14","2008-02-17","MYSORE ROAD"); 
 insert into accident values("15","2005-03-04","KANAKPURA ROAD");
  select * from accident;  
 insert into  participated values("A01","KA052250","11",10000);
 insert into  participated values("A02","KA053408","12",50000);
 insert into  participated values("A03","KA095477","13",25000);
 insert into  participated values("A04","KA031181","14",3000);
 insert into  participated values("A05","KA041702","15",5000);
  select * from participated ;
  select * from person;
  select * from car;
  select * from owns;
  select * from accident;     
  select * from participated ;   
  
  //NESTED QUERY
  /* list the name of drivers whose damage  is greater than the average damage amount*/
select person.name
from person,participated
where person.driver_id=participated.driver_id  and damage_amount>
(select avg(damage_amount) from participated);
/* Update the damage amount to 25000 for the car with a specific reg_num (example 'KA053408') for which the accident report number was 12*/
update participated
set damage_amount=25000 
where reg_num='KA053408' and report_num=12;
/*Find the total number of people who owned cars that were involved in accidents in 2008 */
select count(distinct driver_id) CNT from participated a, accident b
where a.report_num=b.report_num and b.accident_date like '%08';
