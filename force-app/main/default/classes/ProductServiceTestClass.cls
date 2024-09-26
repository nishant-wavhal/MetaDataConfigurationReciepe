/*
Author: Nishant Mohan Wavhal
    Apex Class TestClass for ProductInfoService covering SUCCESS and FAILURE scenarios
*/

@isTest
public with sharing class ProductServiceTestClass {
    @TestSetup
    public static void productservicetestsetup()
    {
        
        Contact c=  new Contact();
        c.Firstname='Test 1';
        c.lastname='Test 1';
        c.Home_Country__c='Germany';
        c.product__c='Metal';
        c.UUID__c='12347484940';
        
        
        Contact c1=  new Contact();
        c1.firstname='Test 2';
        c1.lastname='Test 2';
        c1.Home_Country__c='';
        c1.product__c='Metal';
       
        
        List<Contact> cList =new List<Contact>();
        cList.add(c);
        cList.add(c1);
        
        insert cList;
        
        Case cs= new Case();
        cs.Origin='Email';
        cs.contactid=cList[0].id;
        
        Case cs1= new Case();
        cs1.Origin='Email';
        cs1.contactid=cList[1].id;
        
        Case cs2= new Case();
        cs2.Origin='Email';
        
        List<Case> csList = new List<Case>();
        csList.add(cs);
        csList.add(cs1);
        csList.add(cs2);
        
        insert csList;
    }
    @isTest  
    public static void getProductinfoUUIDtest() {
        Contact c =[select id,uuid__c from Contact limit 1];
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductInfoService'; 
        req.httpMethod = 'POST';
        
        
        RestContext.request = req;
        RestContext.response= res;
        
        Test.startTest();
        ProductInfoService.getCustomerfeatures(c.uuid__c);
        Test.stopTest();
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(RestContext.response.responsebody.toString());
        System.assertEquals(200, RestContext.response.statusCode,'Success');    
        System.assertEquals('Metal', m.get('product'),'Should be metal');
        System.assertEquals('Germany', m.get('homecountry'),'Should be Germany');

    }
    
    @isTest
    public static void getProductinfoUUIDtest1() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductInfoService'; 
        req.httpMethod = 'POST';
        
        RestContext.request = req;
        RestContext.response= res;
        
        Test.startTest();
        ProductInfoService.getCustomerfeatures('123');
        Test.stopTest();
        
        System.assertEquals(400, RestContext.response.statusCode,'error'); 
    }
    
    @isTest  
    public static void getProductinfoUUIDtest2() {
        Contact c =[select id,uuid__c from Contact where lastname='Test 2' limit 1];
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductInfoService'; 
        req.httpMethod = 'POST';
        
        RestContext.request = req;
        RestContext.response= res;
        
        Test.startTest();
        ProductInfoService.getCustomerfeatures(c.uuid__c);
        Test.stopTest();
        
        System.assertEquals(400, RestContext.response.statusCode,'error'); 
    }
    
    @isTest
    public static void getProductinfoUUIDtest3() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductInfoService/'; 
        req.httpMethod = 'POST';
        
        RestContext.request = req;
        RestContext.response= res;
        
        Test.startTest();
        ProductInfoService.getCustomerfeatures(NULL);
        Test.stopTest();
        
        System.assertEquals(400, RestContext.response.statusCode,'error'); 
    }
    
}