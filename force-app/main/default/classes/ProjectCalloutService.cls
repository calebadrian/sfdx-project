public with sharing class ProjectCalloutService {

    @InvocableMethod(label = 'Post Opportunity to PMS')
    public static void postOpportunityToPMS(List <Id> oppIds){
        QueueablePMSCall newPMSCall = new QueueablePMSCall(oppIds);
        Id jobId = System.enqueueJob(newPMSCall);
    }

    public class QueueablePMSCall implements Queueable, Database.AllowsCallouts{
        List <Id> oppIds;

        QueueablePMSCall(List <Id> oppIds){
            this.oppIds = oppIds;
        }

        public void execute(QueueableContext qc){
            List <Opportunity> allOpps = [SELECT Id, Name, Account.Name, CloseDate, Amount FROM Opportunity WHERE Id IN :oppIds];
            List <OpportunityCalloutWrapper> allWrappers = new List <OpportunityCalloutWrapper>();
            for (Opportunity opp : allOpps){
                OpportunityCalloutWrapper temp = new OpportunityCalloutWrapper();
                temp.opportunityId = opp.Id;
                temp.opportunityName = opp.Name;
                temp.accountName = opp.Account.Name;
                temp.closeDate = opp.CloseDate;
                temp.amount = opp.Amount;
                allWrappers.add(temp);
            }
            String wrapperString = JSON.serialize(allWrappers);
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String psToken = ServiceTokens__c.getInstance('ProjectServiceToken').Token__c;
            request.setEndpoint('callout:ProjectService');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Token', psToken);
            request.setBody(wrapperString);
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200){
                for (Opportunity opp : allOpps){
                    opp.StageName = 'Submitted Project';
                }
            } else {
                for (Opportunity opp : allOpps){
                    opp.StageName = 'Resubmit Project';
                }
            }
            update allOpps;
        }
    }

    private class OpportunityCalloutWrapper{
        String opportunityId {get; set;}
        String opportunityName {get; set;}
        String accountName {get; set;}
        Date closeDate {get; set;}
        Decimal amount {get; set;}
    }
}