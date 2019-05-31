@isTest
private class ParkLocatorTest{
    @isTest
    static void testCallout(){
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        String[] results = ParkLocator.country('United States');
        System.assertEquals(2, results.size());
    }
}