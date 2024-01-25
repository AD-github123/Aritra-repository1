use inventory_management_system;
select * from products;
select * from suppliers;
select * from orders;
/*performing analyisis on "products" table*/

/*finding total quantity in sotck*/
select sum(QuantityInStock) 
as Total_Quantity
from products;

/*finding product name with maximum quantity and also its quantity in stock*/
select ProductName 
as Product_With_Max_Quantity, QuantityInStock
from products
where QuantityInStock=(select max(QuantityInStock) from products);

/*finding product name with minimum quantity and also its quantity in stock*/
select ProductName 
as Product_With_Min_Quantity, QuantityInStock
from products
where QuantityInStock=(select min(QuantityInStock) from products);

/*finding product category wise quantity in stock*/
select Category,sum(QuantityInStock) as Total_Quantity
from products
group by(Category);

/*finding product name and its price where price is maximum*/
select ProductName as Product_with_Max_Price, UnitPrice
from products
where UnitPrice=(select max(UnitPrice) from products);

/*finding product name and its price where price is minimum*/
select ProductName as Product_with_Min_Price, UnitPrice
from products
where UnitPrice=(select min(UnitPrice) from products);

/*performing analysis on "suppliers" table*/

/*finding longest suppliername along with its supplierid*/
select SupplierID,SupplierName as Longest_Supplier_Name
from suppliers
where SupplierName=(select max(SupplierName) from suppliers);

/*finding smallest suppliername along with its supplierid*/
select SupplierID,SupplierName as Smallest_Supplier_Name
from suppliers
where SupplierName=(select min(SupplierName) from suppliers);

/*arranging names of contact persons alphabatically*/
select * from suppliers
order by ContactPerson;

/*finding supplier whose phone numbers starts with 1*/
select *
 from suppliers
where PhoneNO like '1%';

/*finding supplier whose phone numbers ends with 9*/
select *
from suppliers
where PhoneNO like '%9';

/*performing analysis on "orders" table*/

/*finding total order amount*/
select sum(OrderAmount) as Total_Order_Amount
from orders;

/*finding minimum order amount*/
select min(OrderAmount) as Highest_Order_Amount
from orders;

/*finding minimum order amount*/
select min(OrderAmount) as Lowest_Order_Amount
from orders;

/*finding total order quantity*/
select sum(QuantityOrdered) as Total_Ordered_Quantity
from orders;

/*finding maximum order quantity*/
select max(quantityOrdered) as Max_Ordered_Quantity
from orders;

/*finding minimum order quantity*/
select min(quantityOrdered) as Min_Ordered_Quantity
from orders;

/*finding total ordered quantity and total order amount for the year 2023*/
select sum(QuantityOrdered) as Total_Quantity_Ordered,
sum(OrderAmount) as Total_Order_Aamount
from orders
where OrderDate like '2023%';

/*finding total ordered quantity and total order amount for the year 2024*/
select sum(QuantityOrdered) as Total_Quantity_Ordered,
sum(OrderAmount) as Total_Order_Aamount
from orders
where OrderDate like '2024%';

/*performing analysis by joining multiple tables*/
/*finding supplier name, contact person and their respective ordered quntities, order amounts*/
select SupplierName, ContactPerson, QuantityOrdered, OrderAmount
from suppliers join orders
using(SupplierID);

/*finding product category wise total order amount*/
select Category, sum(OrderAmount) as Total_Order_Amount
from products join orders
using(ProductID)
group by(Category);

/*finding product name, unit price, quantity in stock, supplier name, contact person, quantity ordered and order amount*/
select ProductName, UnitPrice, QuantityInStock, SupplierName, ContactPerson, QuantityOrdered, OrderAmount
from products  join suppliers  join orders
Using(ProductID,SupplierID);

/*finding supplier id, supplier name, contact person, order id, order amount for the year 2023*/
select SupplierID, SupplierName, ContactPerson, OrderID, OrderAmount
from suppliers join orders
USing(SupplierID)
where OrderDate like '2023%';

/*finding supplier id, supplier name, contact person, order id, order amount for the year 2024*/
select SupplierID, SupplierName, ContactPerson, OrderID, OrderAmount
from suppliers join orders
USing(SupplierID)
where OrderDate like '2024%';

/*finding names of contact persons, order amount and their phone numbers whose order amount is greater than 5000*/
select ContactPerson, OrderAmount, PhoneNO
from suppliers join orders
Using(SupplierID)
where OrderAmount > 5000;

/*arranging product names in ascending order w.r.t. their order amount*/
select ProductName
from products join orders
using(ProductID)
order by OrderAmount asc;

/*finding contact persons and their phone numbers whose orders are older than 1 month*/
select s.ContactPerson, s.PhoneNO
from suppliers s
 join orders o
Using(SupplierID)
where datediff(curdate(),o.OrderDate)>30;
 
 /*finding order id, order amount for December*/
 select o.OrderID, o.OrderAmount
 from Orders o
 where month(OrderDate)=12;
 
 /*finding order id, order amount for January*/
 select o.OrderID, o.OrderAmount
 from Orders o
 where month(OrderDate)=1;
 
 /*finding whether total orderamount for the year 2024 is greater than or not for the year 2023*/
SELECT 
  CASE 
    WHEN SUM(CASE WHEN YEAR(OrderDate) = 2023 THEN OrderAmount else 0 end) >
         SUM(CASE WHEN YEAR(OrderDate) = 2024 THEN OrderAmount else 0  END)
    THEN 'Yes'
    ELSE 'No'
  END AS comparison_result
FROM orders;

/*finding decrease(in %) in total order amount of December and January by rounding the percentage value upto 2 decimal numbers*/
select round(((sum(case when month(OrderDate)=12 then OrderAmount else 0 end)-
sum(case when month(OrderDate)=1 then OrderAmount else 0 end))/sum(case when month(OrderDate)=1 then OrderAmount else 0 end))*100,2)
 as decrease_in_order
from orders;








