@isTest
public with sharing class AddPrimaryContactTest {

    @TestSetup
    static void setup(){
        List <Account> accounts = new List <Account>();
        for (Integer i = 0; i < 100; i++){
            if (i >= 50){
                accounts.add(new Account(name='Test Account' + i, BillingState = 'CA'));
            } else {
                accounts.add(new Account (name='Test Account' + i, BillingState='NY'));
            }
        }
        insert accounts;
    }

    @isTest
    static void testQueueable() {
        Contact newCon = new Contact(FirstName = 'Test', LastName = 'Contact');
        AddPrimaryContact addContacts = new AddPrimaryContact(newCon, 'CA');
        Test.startTest();
        System.enqueueJob(addContacts);
        Test.stopTest();
        System.assertEquals(50, [SELECT COUNT() FROM Contact WHERE Account.BillingState = 'CA']);
    }
}