@isTest
global class ProjectCalloutServiceMock implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"status": "SUCCESS"}');
        response.setStatusCode(200);
        return response;
    }
}