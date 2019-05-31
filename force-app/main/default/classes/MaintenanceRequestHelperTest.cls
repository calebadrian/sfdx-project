@IsTest
private class MaintenanceRequestHelperTest {
    @TestSetup
    static void setup(){
        Product2 testProduct = new Product2();
        testProduct.Maintenance_Cycle__c = 30;
        testProduct.Name = 'bulkProduct';
        insert testProduct;
        Vehicle__c testVehicle = new Vehicle__c();
        testVehicle.Name = 'testVehicle';
        insert testVehicle;
        List <Case> testCases = new List <Case>();
        for (Integer i = 0; i < 300; i++){
            Case testCase = new Case();
            testCase.Subject = 'TestCase' + i;
            testCase.Status = 'New';
            testCase.Type = 'Routine Maintenance';
            testCase.Equipment__c = testProduct.Id;
            testCase.Vehicle__c = testVehicle.Id;
            testCases.add(testCase);
        }
        insert testCases;
        Product2 testProduct1 = new Product2();
        testProduct1.Maintenance_Cycle__c = 60;
        testProduct1.Name = 'positiveProduct';
        insert testProduct1;
        Case positiveTest = new Case();
        positiveTest.Subject = 'PositiveCase';
        positiveTest.Status = 'New';
        positiveTest.Type = 'Repair';
        positiveTest.Equipment__c = testProduct1.Id;
        positiveTest.Vehicle__c = testVehicle.Id;
        insert positiveTest;
        Product2 testProduct2 = new Product2();
        testProduct2.Maintenance_Cycle__c = 90;
        testProduct2.Name = 'negativeProduct';
        insert testProduct2;
        Case negativeTest = new Case();
        negativeTest.Subject = 'NegativeCase';
        negativeTest.Status = 'New';
        negativeTest.Type = 'Repair';
        negativeTest.Equipment__c = testProduct2.Id;
        negativeTest.Vehicle__c = testVehicle.Id;
        insert negativeTest;
    }

    @IsTest
    static void testBulk(){
        List <Case> allCases = [SELECT Id, Date_Reported__c, Date_Due__c, Type, Subject, Status, Equipment__c FROM Case WHERE Status = 'New' AND Subject LIKE 'TestCase%' LIMIT 300];
        List <Case> updatedCases = new List <Case>();
        Id equipmentId = allCases[0].Equipment__c;
        for (Case ca : allCases){
            ca.Status = 'Closed';
            updatedCases.add(ca);
        }
        Test.startTest();
        update updatedCases;
        Test.stopTest();
        System.assertEquals(300, [SELECT COUNT() FROM Case WHERE Equipment__c = :equipmentId AND Status = 'New']);
    }

    @IsTest
    static void testPositive(){
        Case positiveCase = [SELECT Id, Date_Reported__c, Date_Due__c, Type, Subject, Status, Equipment__c, Vehicle__c FROM Case WHERE Status = 'New' AND Subject = 'PositiveCase' LIMIT 1][0];
        Id vehicleId = positiveCase.Vehicle__c;
        Id equipmentId = positiveCase.Equipment__c;
        positiveCase.Status = 'Closed';
        Test.startTest();
        update positiveCase;
        Test.stopTest();
        Case clonedPositive = [SELECT Id, Date_Reported__c, Date_Due__c, Type, Subject, Status, Equipment__c, Vehicle__c FROM Case WHERE Equipment__c = :equipmentId AND Status = 'New' LIMIT 1][0];
        System.assertEquals(Date.Today(), clonedPositive.Date_Reported__c);
        System.assertEquals('New', clonedPositive.Status);
        System.assertEquals('Routine Maintenance', clonedPositive.Type);
        System.assertEquals(equipmentId, clonedPositive.Equipment__c);
        System.assertEquals(vehicleId, clonedPositive.Vehicle__c);
        System.assertEquals(Date.Today() + 60, clonedPositive.Date_Due__c);
    }

    @IsTest
    static void testNegative(){
        Case negativeCase = [SELECT Id, Date_Reported__c, Date_Due__c, Type, Subject, Status, Equipment__c, Vehicle__c FROM Case WHERE Status = 'New' AND Subject = 'NegativeCase' LIMIT 1][0];
        Id equipmentId = negativeCase.Equipment__c;
        negativeCase.Status = 'Working';
        Test.startTest();
        update negativeCase;
        Test.stopTest();
        List <Case> allCases = [SELECT Id FROM Case WHERE Equipment__c = :equipmentId];
        System.assertEquals(1, allCases.size());
    }
}