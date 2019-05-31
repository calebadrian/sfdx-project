@IsTest
private class ProjectRESTServiceTest {
    @IsTest
    static void testPositiveCall(){
        Opportunity testOpportunity = new Opportunity(Name = 'Test Opportunity', StageName = 'Prospecting', CloseDate = Date.Today());
        insert testOpportunity;
        RestRequest request = new RestRequest();
        request.requestUri = 'https://brave-shark-6h3whp-dev-ed.my.salesforce.com/services/apexrest/project';
        request.httpMethod = 'POST';
        RestContext.request = request;
        String ret = ProjectRESTService.postProjectData('Test-Project', 'Test Project', testOpportunity.Id, Date.Today(), Date.Today() + 30, 100000, 'Running');
        System.assertEquals('OK', ret);
    }

    @IsTest
    static void testNegativeCall(){
        Opportunity testOpportunity = new Opportunity(Name = 'Test Opportunity', StageName = 'Prospecting', CloseDate = Date.Today());
        insert testOpportunity;
        RestRequest request = new RestRequest();
        request.requestUri = 'https://brave-shark-6h3whp-dev-ed.my.salesforce.com/services/apexrest/project';
        request.httpMethod = 'POST';
        RestContext.request = request;
        String ret = ProjectRESTService.postProjectData('', 'Test Project', testOpportunity.Id, Date.Today(), Date.Today() + 30, 100000, 'Running');
        System.assertNotEquals('OK', ret);
    }
}