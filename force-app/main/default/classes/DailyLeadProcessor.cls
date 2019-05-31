global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext ctx){
        List <Lead> allLeads = [SELECT Id FROM Lead WHERE LeadSource = '' LIMIT 200];
        List <Lead> toUpdate = new List <Lead>();
        for (Lead ld : allLeads){
            ld.LeadSource = 'Dreamforce';
            toUpdate.add(ld);
        }
        update toUpdate;
    }
}