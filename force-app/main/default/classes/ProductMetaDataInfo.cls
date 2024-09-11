/*
Author: Nishant Mohan Wavhal
Apex Class to ProductMetaDataInfo for retrieving metadat info for features
*/
public with sharing class ProductMetaDataInfo {
        
    public static Product_Subscription__mdt getproductcostconfig(String homecountry,String product)
    { 
        return [select id,atm_fee__c,Card_Replacement_Cost__c,Monthly_Charges__c from Product_Subscription__mdt where home_Country__c=:homecountry and product__c=:Product limit 1 ];
        
    }
    
}