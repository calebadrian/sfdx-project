@isTest
global class ProjectCalloutServiceMockFailure implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"status": "FAILURE"}');
        response.setStatusCode(500);
        return response;
    }
}