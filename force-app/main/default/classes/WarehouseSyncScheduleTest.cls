@isTest
private class WarehouseSyncScheduleTest {
    @isTest
    static void WarehouseSyncScheduleTest() {
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest', '0 0 0 15 3 ? 2022', new WarehouseSyncSchedule());
        Test.stopTest();
        String state = [SELECT Id, State FROM CronTrigger WHERE Id = :jobId LIMIT 1][0].State;
    }
}