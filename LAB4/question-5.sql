Select * from product p inner join 
(Select o.ord_id,o.ord_amount,o.ord_date,o.cus_id,sp.pro_id from order_table o inner join supplier_pricing sp on o.pricing_id=sp.pricing_id where o.cus_id=2)
 t on p.pro_id=t.pro_id;