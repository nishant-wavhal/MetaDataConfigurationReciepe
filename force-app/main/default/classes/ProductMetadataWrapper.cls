/*
Author: Nishant Mohan Wavhal
Product Metadata Wrapper Class for ProductInfo Controller 
and ProductInfoService*/

public class ProductMetadataWrapper 
{
    @AuraEnabled
    public String homecountry;
    @AuraEnabled
    public String product;
    @AuraEnabled
    public String isocode;
    @AuraEnabled
    public  Product_Subscription__mdt productsubscription;
  
    public  ProductMetadataWrapper(String homecountry,String product,
                                   String isocode,Product_Subscription__mdt productsubscription)
  {
        this.homecountry=homecountry;
        this.product=product;
        this.isocode=isocode;
        this.productsubscription=productsubscription;
  }    
}