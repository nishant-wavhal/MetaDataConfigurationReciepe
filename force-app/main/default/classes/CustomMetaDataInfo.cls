/*
Author: Nishant Mohan Wavhal
Apex Class CustomMetaDataInfo for retrieving metadata info for 
as single responsibilty various custom metatdata
*/

public class CustomMetaDataInfo {
        
    public static Product_Subscription__mdt getproductcostconfig(String homecountry,String product)
    { 
        return [select id,atm_fee__c,Card_Replacement_Cost__c,Monthly_Charges__c from Product_Subscription__mdt where home_Country__c=:homecountry and product__c=:Product limit 1 ];
        
    }
    
}