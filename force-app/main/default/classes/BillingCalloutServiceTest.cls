@isTest
private class BillingCalloutServiceTest {

  @TestSetup
  static void makeData(){
    ServiceCredentials__c newCreds = new ServiceCredentials__c();
    newCreds.Username__c = 'bsUser1';
    newCreds.Password__c = 'bsPass1';
    newCreds.Name = 'BillingServiceCredential';
    insert newCreds;
    Opportunity newOpp = new Opportunity();
    newOpp.Name = 'Test Opp';
    newOpp.CloseDate = Date.Today();
    newOpp.Amount = 100;
    newOpp.StageName = 'Prospecting';
    insert newOpp;
    Project__c newProj = new Project__c();
    newProj.Name = 'Test Project';
    newProj.Billable_Amount__c = 100000;
    newProj.Status__c = 'Running';
    newProj.ProjectRef__c = '12345';
    newProj.Opportunity__c = newOpp.Id;
    insert newProj;
  }
  
  @isTest
  static void successCallout(){
    List <Project__c> newProj = [SELECT Id, ProjectRef__c, Billable_Amount__c, Name, Status__c FROM Project__c WHERE ProjectRef__c = '12345'];
    Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());
    Test.startTest();
    newProj[0].Status__c = 'Billable';
    BillingCalloutService.callBillingService(newProj, new List <Project__c> ());
    Test.stopTest();
    System.assertNotEquals('Billed', [SELECT Id, Status__c FROM Project__c WHERE ProjectRef__c = '12345' LIMIT 1][0].Status__c);
  }

  @isTest
  static void failedCallout(){
    List <Project__c> newProj = [SELECT Id, ProjectRef__c, Billable_Amount__c, Name, Status__c FROM Project__c WHERE ProjectRef__c = '12345'];
    Test.setMock(WebServiceMock.class, new BillingCalloutServiceMockFailure());
    Test.startTest();
    newProj[0].Status__c = 'Running';
    BillingCalloutService.callBillingService(newProj, new List <Project__c>());
    Test.stopTest();
    System.assertNotEquals('Billed', [SELECT Id, Status__c FROM Project__c WHERE ProjectRef__c = '12345' LIMIT 1][0].Status__c);
  }
}