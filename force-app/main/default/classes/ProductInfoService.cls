/*
Author: Nishant Mohan Wavhal
Apex Class to Call API Services for External partners so they can access 
Customer product subscription data
*/

@RestResource(urlMapping='/ProductInfoService/*')
global with sharing class ProductInfoService {   
    
    @HttpPOST
    global static void  getCustomerfeatures(String UUID) {
        
        RestRequest req = RestContext.request;
        RestResponse res =RestContext.response;
        
        String contactUUID= UUID;
        Product_Subscription__mdt productsubscription=null;
        
        String homecountry;
        String product;
        String isocode;
        
        if(contactUUID !=null && contactUUID !='')
        {  
            Contact c;
            try
            {
                c=[select id ,home_Country__c,Product__c,CurrencyIsoCode 
                   from 
                   Contact 
                   where 
                   uuid__c =:contactUUID limit 1];
            }
            catch(Exception e)
            {   
                res.statusCode=500;         
                res.responseBody=Blob.valueOf(e.getmessage());               	
            }
            
            
            if(c!=null)
            {
                if(c.home_Country__c!=null &&  c.product__c!=null && 
                   c.home_Country__c!='' && c.product__c!='')
                {        
                    productsubscription= 
                      CustomMetaDataInfo.getproductcostconfig(c.home_Country__c,c.product__c);                     
                    homeCountry=c.home_Country__c;                  
                    product=c.product__c;                   
                    isocode=c.CurrencyIsoCode;

                    if(productsubscription!=null)
                    {           
                        res.statusCode=200; 
                        res.ResponseBody =
                            Blob.valueOf(JSON.serializePretty
                            (new ProductMetadataWrapper(homecountry,product,isocode,productsubscription)));
                    }
                    else
                    {
                        res.statusCode=400; 
                    }
                }

            }
            else
                {
                    res.statusCode=400; 
                    res.responseBody=Blob.valueOf
                                      (JSON.serialize
                                       (new CustomErrorException('500','Contact Value has an Error')));
                }
            
        }
        else
        {		
            res.statusCode=400; 
            res.ResponseBody =Blob.valueOf
                               (JSON.serialize
                                (new CustomErrorException('500','Please Enter Contact UUID')));
        }
        
        
    } 
}