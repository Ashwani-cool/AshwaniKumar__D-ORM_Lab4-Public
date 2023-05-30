Select * from supplier s inner join (Select supp_id, count(Supp_id) from supplier_pricing group by supp_id having count(supp_id)>=2) sp 
 on s.supp_id =sp.supp_id ;