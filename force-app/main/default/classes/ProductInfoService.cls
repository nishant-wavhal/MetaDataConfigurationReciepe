/*
Author: Nishant Mohan Wavhal
Apex Class to Call API Services for External partners
*/
@RestResource(urlMapping='/ProductInfoService/*')
global class ProductInfoService {   
    
    @HttpPOST
    global static void  getCustomerfeatures(String UUID) {
        
        RestRequest req = RestContext.request;
        RestResponse res =RestContext.response;
        
        String contactUUID= UUID;
        ProductMetadataWrapper mdtwrapper=null;
        Product_Subscription__mdt psubscriptioncost;
        
        String homecountry;
        String product;
        String isocode;
        
        if(contactUUID !=null && contactUUID !='')
        {  
            Contact c;
            try
            {
                c=[select id ,home_Country__c,Product__c,CurrencyIsoCode from Contact where uuid__c =:contactUUID limit 1];
            }
            catch(Exception e)
            {            
                res.responseBody=Blob.valueOf(e.getmessage());               	
            }
            
            
            if(c!=null)
            {
                if(c.home_Country__c!=null && c.product__c!=null && c.home_Country__c!='' && c.product__c!='')
                {        
                    psubscriptioncost= ProductMetaDataInfo.getproductcostconfig(c.home_Country__c,c.product__c);                     
                    homeCountry=c.home_Country__c;                  
                    product=c.product__c;                   
                    isocode=c.CurrencyIsoCode;
                }
                else
                {
                    res.responseBody=Blob.valueOf(JSON.serialize(new CustomErrorException('500','Contact Value has an Error')));
                }
            }
            
        }
        else
        {		
            
            res.ResponseBody =Blob.valueOf(JSON.serialize(new CustomErrorException('500','Please Enter Contact UUID')));
        }
        
        if(psubscriptioncost!=null)
        {           
            mdtwrapper= new ProductMetadataWrapper(homecountry,product,isocode,psubscriptioncost);
            res.statusCode=200; 
            res.ResponseBody =Blob.valueOf(JSON.serialize(mdtwrapper));
        }
        else
        {
            res.statusCode=500; 
        }
        
    } 
}