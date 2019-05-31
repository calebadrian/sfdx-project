@RestResource(urlMapping='/project')
global with sharing class ProjectRESTService {
    @HttpPost
    global static String postProjectData(String ProjectRef, String ProjectName, String OpportunityId, Date StartDate, Date EndDate, Double Amount, String Status){
        String ret = 'OK';
        Opportunity newOpp = [SELECT Id, DeliveryInstallationStatus__c FROM Opportunity WHERE Id = :OpportunityId LIMIT 1][0];
        newOpp.DeliveryInstallationStatus__c = 'In Progress';
        Project__c newProj = new Project__c();
        newProj.ProjectRef__c = ProjectRef;
        newProj.Name = ProjectName;
        newProj.Opportunity__c = OpportunityId;
        newProj.Start_Date__c = StartDate;
        newProj.End_Date__c = EndDate;
        newProj.Billable_Amount__c = Amount;
        newProj.Status__c = Status;
        Savepoint sp = Database.setSavepoint();
        try {
            upsert newProj ProjectRef__c;
            update newOpp;
        } catch (Exception e){
            Database.rollback(sp);
            ret = e.getMessage();
        }
        return ret;
    }
}