@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        Integer lastSlash = request.requestURI.lastIndexOf('/');
        String accountId = request.requestURI.substring(lastSlash - 18, lastSlash);
        Account result = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id = :accountId];
        return result;
    }
}