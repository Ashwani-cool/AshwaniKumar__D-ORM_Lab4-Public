Select Count(CUS_GENDER) from customer c inner join order_table  o on c.CUS_ID = o.CUS_ID where o.ORD_AMOUNT>=3000 group by c.CUS_GENDER;