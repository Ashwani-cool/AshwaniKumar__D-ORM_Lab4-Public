Select p.pro_id, pro_name from product p inner join (
 Select o.ord_date,sp.pricing_id,sp.pro_id from order_table o inner join supplier_pricing sp on o.pricing_id= sp.pricing_id where ord_date>'2021-10-05') 
 t on p.pro_id=t.pro_id;