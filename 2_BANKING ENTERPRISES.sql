create table Branch(
branch_name varchar(30),
branch_city varchar(30),
assets real,
primary key(branch_name)
);
create table BankAccount(
acc_num int,
branch_name varchar(30),
balance real,
primary key(acc_num),
foreign key(branch_name) references Branch(branch_name)
);
create table BankCustomer(
customer_name varchar(30),
customer_street varchar(30),
customer_city varchar(30),
primary key(customer_name)
);
create table Depositer(
customer_name varchar(30),
acc_num int,
primary key(customer_name,acc_num),
foreign key(customer_name) references BankCustomer(customer_name),
foreign key(acc_num) references BankAccount(acc_num)
);
create table loan(
loan_num int,
branch_name varchar(30),
amount real,
primary key(loan_num),
foreign key(branch_name) references Branch(branch_name)
);
insert into branch values("SBI_Chamarajpet","Bangalore",50000),("SBI_ResidencyRoad","Bangalore",10000),
("SBI_ShivajiRoad","Bombay",20000),("SBI_ParlimentRoad","Delhi",10000),("SBI_Jantarmantar","Delhi",20000);
select * from Branch;
insert into BankAccount values(1,"SBI_Chamarajpet",2000),(2,"SBI_ResidencyRoad",5000),(3,"SBI_ShivajiRoad",6000),
(4,"SBI_ParlimentRoad",9000),(5,"SBI_Jantarmantar",8000),(6,"SBI_ShivajiRoad",4000),
(8,"SBI_ResidencyRoad",4000),(9,"SBI_ParlimentRoad",3000),(10,"SBI_ResidencyRoad",5000),
(11,"SBI_Jantarmantar",2000);
select * from BankAccount;
insert into BankCustomer values("Avinash","bull_temple_road","Bangalore"),("Dinesh","Bannergatta_road","Bangalore"),
("Mohan","Nationalcollege_road","Bangalore"),("Nikil","Akbar_road","Delhi"),("Ravi","Prithviraj","Delhi");
select * from BankCustomer;
insert into Depositer values("Avinash",1),
("Dinesh",2),
("Nikil",4),
("Ravi",5),
("Avinash",8),
("Nikil",9),
("Dinesh",10),
("Nikil",11);
select * from Depositer;
insert into Loan values(1,"SBI_Chamarajpet",1000),
(2,"SBI_ResidencyRoad",2000),
(3,"SBI_ShivajiRoad",3000),
(4,"SBI_ParlimentRoad",4000),
(5,"SBI_Jantarmantar",5000);
select * from Loan;
select * from Branch;
select * from BankAccount;
select * from BankCustomer;
select * from Depositer;
select customer_name from Depositer group by customer_name having count(*)>1
/* Find Find all the customers who have at least two deposits at the same branch */
Select C.customername 
from BankCustomer C
where exits(
select D.customername, count(D.customername)
                     from depositer D, BankAccount BA
                    where 
                          D.accno =BA.accno AND
                          C.customername =D.customername AND
                          BA.branchname =”SBI_ResidencyRoad”
                      Group by D.customername 
                       Having count(D.customername)>=2;
);
/*Find all the customers who have an account at all the branches located in a specific city (Ex. Delhi) */
select BC.customername
from BankCustomer BC
where not exists  (        select bracnhname from Branch where branchcity=‘Delhi’
                                minus
                                (select BA.branchname from Depositer D, BankAccount BA
                                  where D.accno=BA.accno and BC.customername=D.customername)
                               );
 /*Demonstrate how you delete all account tuples at every branch located in a specific city (Ex. Bomay) */
 delete  from BankAccount
where branchname IN (
                                   select branchname
                                   from Branch
                                   where branchcity=‘BOMBAY’
                                      );
