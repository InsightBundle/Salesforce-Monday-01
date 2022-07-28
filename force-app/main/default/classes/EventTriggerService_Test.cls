@isTest
public class EventTriggerService_Test {
    @isTest
    public static void testTrigger(){
        test.startTest();
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='test@test.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@insightbundle.com');
        insert u;

        Test.setMock(HttpCalloutMock.class, new MockCallOut_Test());
        Account a= new Account();
        a.name='Test Account';
        insert a;
        
        Event e = new Event();
        e.WhatId=a.id;
        e.Description = 'test';
        e.Subject ='Subject';
        e.StartDateTime=system.today();
        e.EndDateTime=system.today()+5;
        e.OwnerId = u.id;
        insert e;
        test.stopTest();
    }
}