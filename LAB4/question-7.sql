 Select tbl.pro_id,tbl.pro_name,c.cat_id,c.cat_name,tbl.supp_price from category c inner join (Select p.pro_id,p.pro_name,p.cat_id,t.supp_price from product p inner join (
Select Pro_id,supp_price from supplier_pricing where supp_price in (
 Select MIN(Supp_price)  from product p inner join supplier_pricing sp on p.pro_id = sp.pro_id group by CAT_ID)
 ) t on p.pro_id=t.pro_id) 
 tbl on c.cat_id=tbl.cat_id;