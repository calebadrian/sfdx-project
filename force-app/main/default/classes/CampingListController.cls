public with sharing class CampingListController {

    public List <Camping_Item__c> getItems(){
        List <Camping_Item__c> allItems = [SELECT Id, Name, Quantity__c, Price__c, Packed__c FROM Camping_Item__c];
        return allItems;
    }

    public Camping_Item__c saveItem(Camping_Item__c newItem){
        upsert newItem;
        return newItem;
    }
}