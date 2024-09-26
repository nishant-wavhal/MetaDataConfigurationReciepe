/*
Author: Nishant Mohan Wavhal
Apex Class TestClass for ProductInfoTestClass covering Admin ,
Support User scenarios with Excpetions.
*/

@isTest
public with sharing class ProductInfoTestClass {
    @TestSetup
    public static void productservicetestsetup()
    {
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId() limit 1];
        System.runAs (thisUser) 
        {
            
            Id roleeuId = [Select Id From UserRole where Name='Support APAC'].Id;
            Id roleinId = [Select Id From UserRole where Name='Support EMEA'].Id;
            Id roleukId = [Select Id From UserRole where Name='Support UK'].Id;
            
            Id supportprofileId = [Select Id From Profile Where Name ='Custom: Support Profile'].Id;
            
            
            User supportusereu = new User(FirstName = 'supporteufName',LastName = 'supportlName',email = 'supporteu@sfdc.org',Username = 'supporteu2345fName@sfdc.org',EmailEncodingKey = 'ISO-8859-1',Alias ='sEuro',TimeZoneSidKey = 'America/Los_Angeles',LocaleSidKey = 'en_US',LanguageLocaleKey = 'en_US',ProfileId = supportprofileId,UserRoleId=roleeuId,CurrencyIsoCode='EUR');
            User supportuseruk = new User(FirstName = 'supportukfName',LastName = 'supportlName',email = 'supportuk@sfdc.org',Username = 'supportus7893fName@sfdc.org',EmailEncodingKey = 'ISO-8859-1',Alias = 'sUsd',TimeZoneSidKey = 'America/Los_Angeles',LocaleSidKey = 'en_US',LanguageLocaleKey = 'en_US',ProfileId = supportprofileId,UserRoleId=roleukId,CurrencyIsoCode='GBP' );
            User supportuserinr = new User(FirstName = 'supportinrfName',LastName = 'supportlName',email = 'supportinr@sfdc.org',Username = 'supportin36474fName@sfdc.org',EmailEncodingKey = 'ISO-8859-1',Alias ='sInr',TimeZoneSidKey = 'America/Los_Angeles',LocaleSidKey = 'en_US',LanguageLocaleKey = 'en_US',ProfileId = supportprofileId,UserRoleId=roleinId,CurrencyIsoCode='INR');
            
            List<User> uList= new List<User>();
            uList.add(supportusereu);
            uList.add(supportuseruk);
            uList.add(supportuserinr);
            
            
            insert uList;
        }
        
        Contact c=  new Contact();
        c.Firstname='Test 1';
        c.lastname='Test 1';
        c.Home_Country__c='Germany';
        c.product__c='Metal';
        c.currencyIsocode='EUR';
        
        Contact c1=  new Contact();
        c1.firstname='Test 2';
        c1.lastname='Test 2';
        c1.Home_Country__c='United Kingdom';
        c1.product__c='Metal';
        c1.currencyIsocode='GBP';
        
        List<Contact> cList =new List<Contact>();
        cList.add(c);
        cList.add(c1);
        
        insert cList;
        
        
        List<Contact> cList1= [select id from Contact];
        Case cs= new Case();
        cs.Origin='Email';
        cs.contactid=cList1[0].id;
        
        Case cs1= new Case();
        cs1.Origin='Email';
        cs1.contactid=cList1[1].id;
        
        Case cs2= new Case();
        cs2.Origin='Email';
        
        List<Case> csList = new List<Case>();
        csList.add(cs);
        csList.add(cs1);
        csList.add(cs2);
        
        insert csList;
    }
    
    @isTest  
    public static void getProductinfoUUIDtest1() {
        User u = [select id from User where FirstName='supporteufName'];
        
        System.runAs(u) 
        {
            
            Contact con = new Contact();       
            con.Firstname='Test 1';
            con.lastname='Test 1';
            con.Home_Country__c='Germany';
            con.product__c='Metal';
            con.currencyIsocode='EUR';
            insert con;
            
            Case c= new Case();
            c.Origin='Email';
            c.contactid=con.id;
            insert c;
            
            
            Test.startTest();
            ProductMetadataWrapper mwrap=ProductInfoController.getServices(c.id);   
            System.assertEquals('Germany', mwrap.homecountry);
            System.assertEquals('Metal', mwrap.product);
            System.assertEquals('EUR', mwrap.isocode);
            System.assertEquals(16.90, mwrap.productsubscription.Monthly_Charges__c);
            System.assertEquals(45.00, mwrap.productsubscription.Card_Replacement_Cost__c);
            System.assertEquals(0.00, mwrap.productsubscription.ATM_Fee__c);
            Test.stopTest();
        }
        
    }
    
    @isTest  
    public static void getProductinfoUUIDtest11() {
        
        Case c =[select id from Case limit 1];   
        Test.startTest();
        ProductMetadataWrapper mwrap=ProductInfoController.getServices(c.id);
        System.assertEquals('Germany', mwrap.homecountry);
        System.assertEquals('Metal', mwrap.product);
        System.assertEquals('EUR', mwrap.isocode);
        System.assertEquals(16.90, mwrap.productsubscription.Monthly_Charges__c);
        System.assertEquals(45.00, mwrap.productsubscription.Card_Replacement_Cost__c);
        System.assertEquals(0.00, mwrap.productsubscription.ATM_Fee__c);
        Test.stopTest();
        
    }
    
    @isTest  
    public static void getProductinfoUUIDtest2() {
        User u = [select id from User where FirstName='supportukfName'];
        
        System.runAs(u) 
        {
            Contact con = new Contact();       
            con.Firstname='Test 1';
            con.lastname='Test 1';
            con.Home_Country__c='United Kingdom';
            con.product__c='Standard';
            con.currencyIsocode='GBP';
            insert con;
            
            Case c= new Case();
            c.Origin='Email';
            c.contactid=con.id;
            insert c;
            
            Test.startTest();
            ProductMetadataWrapper mwrap=ProductInfoController.getServices(c.id);
            System.assertEquals('United Kingdom', mwrap.homecountry);
            System.assertEquals('Standard', mwrap.product);
            System.assertEquals('GBP', mwrap.isocode);
            System.assertEquals(0.00, mwrap.productsubscription.Monthly_Charges__c);
            System.assertEquals(6.00, mwrap.productsubscription.Card_Replacement_Cost__c);
            System.assertEquals(1.70, mwrap.productsubscription.ATM_Fee__c);
            Test.stopTest();
        }
        
    }
    
    public static void getProductinfoUUIDtest22() {
        List<Case> cList =[select id from Case];
        Test.startTest();
        ProductMetadataWrapper mwrap=ProductInfoController.getServices(cList[1].id);
        System.assertEquals('United Kingdom', mwrap.homecountry);
        System.assertEquals('Standard', mwrap.product);
        System.assertEquals('GBP', mwrap.isocode);
        System.assertEquals(0.00, mwrap.productsubscription.Monthly_Charges__c);
        System.assertEquals(6.00, mwrap.productsubscription.Card_Replacement_Cost__c);
        System.assertEquals(1.70, mwrap.productsubscription.ATM_Fee__c);
        Test.stopTest();
        
    }
    
    @isTest  
    public static void getProductinfoUUIDtest3() {
        User u = [select id from User where FirstName='supportinrfName'];
        
        System.runAs(u) 
        {
            Contact con = new Contact();       
            con.Firstname='Test 1';
            con.lastname='Test 1';
            con.Home_Country__c='';
            con.product__c='';
            con.currencyIsocode='GBP';
            insert con;
            
            Case c= new Case();
            c.Origin='Email';
            c.contactid=con.id;
            insert c;
            
            Test.startTest();
            try{
                ProductMetadataWrapper mwrap=ProductInfoController.getServices(c.id);
            } catch(Exception e)
            {
                Assert.areEqual('Script-thrown exception',e.getmessage());
            }
            Test.stopTest();
        }
        
    }  
    
    @isTest  
    public static void getProductinfoUUIDtest33() {
        
        List<Case> cList =[select id from Case];
        
        Test.startTest();
        try{
            ProductMetadataWrapper mwrap=ProductInfoController.getServices(cList[2].id);
        } catch(Exception e)
        {
            Assert.areEqual('Script-thrown exception',e.getmessage());
        }
        Test.stopTest();
    }    
    
    @isTest  
    public static void getProductinfoUUIDtest4() {
        Test.startTest();
        try{ProductMetadataWrapper mwrap=ProductInfoController.getServices('5007Q00000C3Ta9QAF');}
        catch(Exception e)
        {
            Assert.areEqual('List has no rows for assignment to SObject',e.getmessage());
        }
        
        Test.stopTest();
        
    }
}