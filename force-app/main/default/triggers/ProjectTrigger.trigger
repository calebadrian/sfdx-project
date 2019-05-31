trigger ProjectTrigger on Project__c (after update) {
   
   if (Trigger.isBefore){
       if (Trigger.isInsert){

       } else if (Trigger.isUpdate){
           BillingCalloutService.callBillingService(Trigger.New, Trigger.Old);
       }
   } else if (Trigger.isAfter){
       if(Trigger.isInsert){

       } else if (Trigger.isUpdate){
       }
   }
}