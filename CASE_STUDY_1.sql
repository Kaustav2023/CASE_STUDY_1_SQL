--create database Case_Study_1
--use Case_Study_1
select * from fact
select * from Product
select * from location

--1.>.................
select Count(Distinct State) AS [Number Of States] from location 

--2.>.................
Select Count(product) as [Count of Product] from Product where Type='Regular'

--3.>.................
select Sum(Marketing) as [Total Spent in Marketing] from fact where productid=1

--4.>.................
select MIN(Sales) as [Minimum Sales] from fact 

--5.>.................
select Max(COGS) as [Max Cost of Goods Sale] from fact 

--6.>.................
select * from product where product_type='coffee'

--7.>..................
select * from fact where total_expenses>40

--8.>..................
select Avg(sales) as [Average Sales] from fact where area_code=719

--9.>..................
select sum(profit) as [Profit Generated] from fact left join location on fact.area_code=location.area_code where location.state='Colorado'

--10.>................
select productid, Avg(inventory) AS [Average Inventory] from fact group by productid order by productid ASC


--11.>................
select * from location order by state 

--12.>.................
select productid, avg(budget_margin) as [AVERAGE BUDGET] from fact group by productid having avg(budget_margin)>100

--13.>.................
select sum(sales) as SALES_NUMBER from fact where Date='2010-01-01'
 
--14.>.................
select productid, date, AVG(TOTAL_EXPENSES) AS [AVG TOTAL EXPENSES] FROM FACT GROUP BY productid, date

--15.>.................
select F.Date,F.Productid, P.Product_Type, P.Product, F.Sales,F.Profit,L.State,F.Area_code from Fact as F left join Product as P on F.Productid=P.Productid  
left join Location as L on F.Area_Code = L.Area_code

--16.>.................
select date, productid, sales, profit, area_code,
dense_RANK () OVER (ORDER BY sales) AS dense_Rank_no
from fact

--17.>.................
select L.state ,sum(profit)as [TOTAL PROFIT],sum(sales) as [TOTAL SALES] from fact as F left join Location as L on F.Area_Code=L.Area_code group by L.state

--18.>.................
select P.product, L.state ,sum(profit)as [TOTAL PROFIT],sum(sales) as [TOTAL SALES] 
from fact as F left join Location as L on F.Area_Code=L.Area_code left join Product as P on F.productID = P.productID group by L.state,P.product

--19.>.................
select sales, (sales*1.05)as [Increased Sales] from fact 

--20.>................
select F.Productid,P.Product_Type, F.PROFIT from Fact as F left join Product as P on F.productid=P.productid  
where F.profit=(select Max(profit) from Fact)

--21.>................
create Procedure ProductType @P_Type Varchar(50) AS
select * from product where product_type=@P_Type 

EXEC ProductType @P_Type='Coffee'
EXEC ProductType @P_Type='TEA'
EXEC ProductType @P_Type='Espresso'

--22.>................
select *,
STATUS=
case
when Total_Expenses<60 
then 'PROFIT'
else 'LOSS'
end 
from fact

--OR

select * ,IIF(Total_Expenses>60,'LOSS','PROFIT')AS STATUS from fact 

--23.>.................
SELECT DATEPART(WEEK, [DATE]) AS [WEEKLY SALES], DATE, PRODUCTID, SUM(SALES) AS TOTAL_SALES
FROM FACT GROUP BY ROLLUP(DATEPART(WEEK, [DATE]), DATE, PRODUCTID)

--24.>.................
select area_code from fact 
union 
select area_code from location 

select area_code from fact 
Intersect 
select area_code from location 

--25.>..................
create function Func_Type (@type varchar(30))
returns table as 
return select * from product where product_type=@type

select * from dbo.func_type('Coffee')

--26.>..................
select * from product

begin transaction 
update product
set product_type='TEA'
where productid=1

select * from product

rollback transaction

select * from product

--27.>...................
select date,productid,sales from fact where total_expenses between 100 and 200

--28.>...................
select * from product

delete from product where type='Regular' 

--29.>..................
select product, (ASCII(Substring(product,5,1))) as [ASCII Value of FIFTH CHARACTER] from product

--.............................................................................................................

