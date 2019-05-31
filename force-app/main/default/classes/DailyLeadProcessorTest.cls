@isTest
private class DailyLeadProcessorTest {
    
    @TestSetup
    static void setup(){
        List <Lead> allLeads = new List <Lead>();
        for (Integer i = 0; i < 200; i++){
            allLeads.add(new Lead (FirstName = 'Test', LastName = 'Lead' + i, Company = 'Test Company', LeadSource = ''));
        }
        insert allLeads;
    }

    @isTest
    static void runTest(){
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest','0 0 0 15 3 ? 2022',new DailyLeadProcessor());
        Test.stopTest();
        System.assertEquals(200, [SELECT COUNT() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }
}