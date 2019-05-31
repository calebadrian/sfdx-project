@IsTest
global class BillingCalloutServiceMockFailure implements WebServiceMock {
   global void doInvoke(
      Object stub,
      Object request,
      Map<String, Object> response,
      String endpoint,
      String soapAction,
      String requestName,
      String responseNS,
      String responseName,
      String responseType){
      BillingServiceProxy.billProjectResponse_element newRes = new BillingServiceProxy.billProjectResponse_element();
      newRes.status = 'FAILED';
      response.put('response_x', newRes);
   }
}