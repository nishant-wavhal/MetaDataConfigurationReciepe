/*
Author: Nishant Mohan Wavhal
Product Metadata Wrapper Class 
*/
global with sharing class ProductMetadataWrapper {
    @AuraEnabled
    global String homecountry;
    @AuraEnabled
    global String product;
    @AuraEnabled
    global String isocode;
    @AuraEnabled
    global  Product_Subscription__mdt psubscriptioncost;
  

  global  ProductMetadataWrapper(String homecountry,String product,String isocode,Product_Subscription__mdt psubscriptioncost){
      this.homecountry=homecountry;
      this.product=product;
      this.isocode=isocode;
      this.psubscriptioncost=psubscriptioncost;
     }  
}