public with sharing class BoatSearchFormController {
    
    @AuraEnabled
    public static List <BoatType__c> getTypeValues(){
        return [SELECT Name FROM BoatType__c];
    }
}