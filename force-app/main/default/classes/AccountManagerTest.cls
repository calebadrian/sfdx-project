@IsTest
private class AccountManagerTest {
    @IsTest
    static void testGetContacts(){
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id);
        insert testContact;
        RestRequest request = new RestRequest();
        request.requestUri = 'https://brave-shark-6h3whp-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + testAccount.Id + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account results = AccountManager.getAccount();
        System.assertEquals(results.Name, 'Test Account');
    }
}