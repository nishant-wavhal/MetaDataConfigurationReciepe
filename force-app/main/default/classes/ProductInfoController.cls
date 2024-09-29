/*
Author: Nishant Mohan Wavhal
Apex Class for providing Service Agents with data to view of features
while handling support case via LWC
*/

public with sharing class ProductInfoController {
    @AuraEnabled(cacheable=true)
    public static ProductMetadataWrapper getServices(Id caseId){
        
        ProductMetadataWrapper productconfigwrapper=null;     
        Product_Subscription__mdt productsubscription=null;
        
        String homecountry;
        String product;
        String isocode;
        
        if(caseId !=null)
        {
            Case cs = [select id,ContactId,contact.home_Country__c,
                        contact.CurrencyIsoCode,contact.Product__c 
                       from Case 
                       where 
                       id =:caseId WITH USER_MODE limit 1];
           
            if(cs!=null)
            { 
                if(cs.ContactId!=null)
                {

                    if(cs.contact.home_Country__c!=null  && cs.contact.product__c!=null && 
                       cs.contact.home_Country__c!='' && cs.contact.product__c!='')
                    {
                        productsubscription = 
                         CustomMetaDataInfo.getproductcostconfig(cs.contact.home_Country__c,cs.contact.product__c);                     
                        homeCountry=cs.contact.home_Country__c;
                        product=cs.contact.product__c;
                        isocode=cs.contact.CurrencyIsoCode;
                        
                        if(productsubscription!=null)
                        {
                         productconfigwrapper= 
                          new ProductMetadataWrapper(homecountry,product,isocode,productsubscription);
                        } 
                    }
                    else
                        throw new AuraHandledException('Contact has Product / Home Country missing'); 
                }
                else
                    throw new AuraHandledException('Contact Value is Null'); 
            }
            
        }
       
        return productconfigwrapper;         
    } 
}