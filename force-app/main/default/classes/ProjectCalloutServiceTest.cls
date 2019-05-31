@isTest
private class ProjectCalloutServiceTest {
    @TestSetup
    static void makeData(){
        ServiceTokens__c newToken = new ServiceTokens__c();
        newToken.Name = 'ProjectServiceToken';
        newToken.Token__c = '9b045489-b747-4e70-b62a-9bee004ac571';
        insert newToken;
    }
    @isTest
    static void successCallout(){
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        insert testAccount;
        Opportunity testOpp = new Opportunity();
        testOpp.Name = 'Test Opportunity';
        testOpp.CloseDate = Date.Today();
        testOpp.Amount = 100000;
        testOpp.Type = 'New Project';
        testOpp.StageName = 'Prospecting';
        testOpp.AccountId = testAccount.Id;
        insert testOpp;
        List <Id> allOpps = new List <Id>();
        allOpps.add(testOpp.Id);
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock());
        Test.startTest();
        ProjectCalloutService.postOpportunityToPMS(allOpps);
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Opportunity WHERE StageName = 'Submitted Project']);
    }

    @isTest
    static void failedCallout(){
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        insert testAccount;
        Opportunity testOpp = new Opportunity();
        testOpp.Name = 'Test Opportunity';
        testOpp.CloseDate = Date.Today();
        testOpp.Amount = 100000;
        testOpp.Type = 'New Project';
        testOpp.StageName = 'Prospecting';
        testOpp.AccountId = testAccount.Id;
        insert testOpp;
        List <Id> allOpps = new List <Id>();
        allOpps.add(testOpp.Id);
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMockFailure());
        Test.startTest();
        ProjectCalloutService.postOpportunityToPMS(allOpps);
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Opportunity WHERE StageName = 'Resubmit Project']);
    }
}