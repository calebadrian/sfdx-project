@isTest
private class WarehouseCalloutServiceTest {
  @isTest
  static void testCallout(){
    Product2 testProduct = new Product2();
    testProduct.Warehouse_SKU__c = '100003';
    testProduct.Name = 'Generator 1000 kW';
    insert testProduct;
    Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
    Test.startTest();
    WarehouseCalloutService.runWarehouseEquipmentSync();
    Test.stopTest();
    System.assertEquals(2, [SELECT COUNT() FROM Product2 WHERE Warehouse_SKU__c = '100003' OR Warehouse_SKU__c = '200001']);
  }
}