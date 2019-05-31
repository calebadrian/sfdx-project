public class BillingCalloutService implements Database.AllowsCallouts{

    public static void callBillingService(List <Project__c> newProj, List <Project__c> oldProj){
        String newProjList = JSON.serialize(newProj);
        makeCall(newProjList);
    }

    @future (callout = true)
    public static void makeCall(String jsonString){
        List <Project__c> newProj = (List <Project__c>) JSON.deserialize(jsonString, List<Project__c>.class);
        ServiceCredentials__c creds = ServiceCredentials__c.getInstance('BillingServiceCredential');
        BillingServiceProxy.InvoicesPortSoap11 bspCall = new BillingServiceProxy.InvoicesPortSoap11();
        for (Project__c proj : newProj){
            if (proj.Status__c == 'Billable'){
                BillingServiceProxy.project temp = new BillingServiceProxy.project();
                temp.projectId = proj.ProjectRef__c;
                temp.billAmount = proj.Billable_Amount__c;
                temp.username = creds.Username__c;
                temp.password = creds.Password__c;
                String response = bspCall.billProject(temp);
                if (response == 'OK'){
                    proj.Status__c = 'Billed';
                    update proj;
                }
            }
        }
    }
}