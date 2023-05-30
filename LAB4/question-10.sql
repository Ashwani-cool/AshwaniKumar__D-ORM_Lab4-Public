/*creating the procedure*/
DROP PROCEDURE IF EXISTS GetSupplierRatings;

DELIMITER //
CREATE PROCEDURE GetSupplierRatings()
BEGIN
    Select s.supp_id,s.supp_name,
    Case 
    when tbl.RAT_RATSTARS=5 then "Excellent"
    When tbl.RAT_RATSTARS>4 then "Good Service"
    when tbl.RAT_RATSTARS>2 then "Average Service"
    else "Poor Service"
    End as type_of_service
    from supplier s inner join 
    (Select sp.pricing_id,sp.supp_id,t.RAT_RATSTARS from supplier_pricing sp inner join (
    Select r.ord_id,r.RAT_RATSTARS,o.pricing_id from rating r inner join order_table o on r.ord_id=o.ord_id) t 
    on sp.pricing_id=t.pricing_id) tbl

    on s.supp_id-tbl.supp_id
END//
DELIMITER ;

=======================================

/*calling the procedure*/
call GetSupplierRatings();