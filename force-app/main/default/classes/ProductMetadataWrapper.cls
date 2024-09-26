/*
Author: Nishant Mohan Wavhal
Product Metadata Wrapper Class for ProductInfo Controller 
and ProductInfoService*/

global class ProductMetadataWrapper {
    @AuraEnabled
    global String homecountry;
    @AuraEnabled
    global String product;
    @AuraEnabled
    global String isocode;
    @AuraEnabled
    global  Product_Subscription__mdt productsubscription;
  

  global  ProductMetadataWrapper(String homecountry,String product,String isocode,Product_Subscription__mdt productsubscription){
      this.homecountry=homecountry;
      this.product=product;
      this.isocode=isocode;
      this.productsubscription=productsubscription;
     }  
}