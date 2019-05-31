trigger MaintenanceRequest on Case (before insert, before update, after update, after insert) {
    
    MaintenanceRequestHelper MRH = new MaintenanceRequestHelper();
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){

        }else if(Trigger.isUpdate){

        }
    }else if(Trigger.isAfter){
        if(Trigger.isInsert){

        }else if(Trigger.isUpdate){
            MRH.afterUpdate(Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.OldMap);
        }
    } 
}