public class MaintenanceRequestHelper {
    public void afterUpdate(List <Case> newCases, List <Case> oldCases, Map <Id, Case> newCasesMap, Map <Id, Case> oldCasesMap){
        Set <Id> closedIds = new Set <Id>();
        Set <Id> equipmentIds = new Set <Id>();
        List <Case> casesToInsert = new List <Case>();
        Map <Id, Case> caseMap = new Map <Id, Case>();
        Map <Id, Id> caseToEquipmentMap = new Map <Id, Id>();
        Map <Id, Product2> equipmentMap = new Map <Id, Product2>();
        for (Case ca : newCases){
            if (ca.Status == 'Closed' && (ca.Type == 'Repair' || ca.Type == 'Routine Maintenance')){
                closedIds.add(ca.Id);
                Case tempCase = ca.clone();
                caseMap.put(ca.Id, tempCase);
                equipmentIds.add(ca.Equipment__c);
                caseToEquipmentMap.put(ca.Id, ca.Equipment__c);
            }
        }
        List <Product2> allEquipment = [SELECT Id, Maintenance_Cycle__c FROM Product2 WHERE Id IN :equipmentIds];
        for (Product2 temp : allEquipment){
            equipmentMap.put(temp.Id, temp);
        }
        for (Id tempId : caseMap.keySet()){
            Case newCase = caseMap.get(tempId);
            newCase.Date_Reported__c = Date.Today();
            newCase.Date_Due__c = Date.Today() + (Integer) equipmentMap.get(caseToEquipmentMap.get(tempId)).Maintenance_Cycle__c;
            newCase.Type = 'Routine Maintenance';
            newCase.Subject = 'Routine Maintenance ' + String.valueOf(newCase.Date_Due__c);
            newCase.Status = 'New';
            casesToInsert.add(newCase);
        }
        insert casesToInsert;
        // List <Work_Part__c> allParts = [SELECT Id, Equipment__c, Equipment__r.Maintenance_Cycle__c, Maintenance_Request__c, Name, Quantity__c FROM Work_Part__c WHERE Maintenance_Request__c IN :closedIds];
        //     for (Work_Part__c workPart : allParts){
        //         if (partMap.containsKey(workPart.Maintenance_Request__c)){
        //             List <Work_Part__c> caseParts = partMap.get(workPart.Maintenance_Request__c);
        //             caseParts.add(workPart);
        //             partMap.put(workPart.Maintenance_Request__c, caseParts);
        //         } else {
        //             partMap.put(workPart.Maintenance_Request__c, new List <Work_Part__c> {workPart});
        //         }
        //     }
        //     for (Id temp : caseMap.keySet()){
        //         Case tempCase = caseMap.get(temp);
        //         List <Work_Part__c> tempParts = partMap.get(temp);
        //         Decimal tempCycle = 0;
        //         for (Work_Part__c tempWP : tempParts){
        //             if (tempCycle == 0){
        //                 tempCycle = tempWP.Equipment__r.Maintenance_Cycle__c;
        //             } else if (tempWP.Equipment__r.Maintenance_Cycle__c < tempCycle){
        //                 tempCycle = tempWP.Equipment__r.Maintenance_Cycle__c;
        //             }
        //         }
        //         tempCase.Date_Reported__c = Date.Today();
        //         tempCase.Date_Due__c = tempCase.Date_Reported__c + (Integer) tempCycle;
        //         tempCase.Type = 'Routine Maintenance';
        //         tempCase.Subject = 'Routine Maintenance ' + String.valueOf(tempCase.Date_Due__c);
        //         tempCase.Status = 'New';
        //         caseMap.put(temp, tempCase);
        //     }
        //     insert caseMap.values();
        //     List <Work_Part__c> toInsert = new List <Work_Part__c>();
        //     for (Id tempId : caseMap.keySet()){
        //         for (Work_Part__c tempWorkPart : partMap.get(tempId)){
        //             Work_Part__c newPart = tempWorkPart.clone();
        //             newPart.Maintenance_Request__c = caseMap.get(tempId).Id;
        //             toInsert.add(newPart);
        //         }
        //     }
        //     insert toInsert;
    }     
    
}