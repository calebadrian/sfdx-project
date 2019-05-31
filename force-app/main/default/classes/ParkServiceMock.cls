@isTest
global class ParkServiceMock implements WebServiceMock {
    global void doInvoke(
        Object stub,
        Object request,
        Map <String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType){
            ParkService.byCountryResponse response_x = new ParkService.byCountryResponse();
            List <String> allparks = new List<String>();
            allParks.add('Test Park');
            allParks.add('Test Park1');
            response_x.return_x = allParks;
            response.put('response_x', response_x);
        }
}