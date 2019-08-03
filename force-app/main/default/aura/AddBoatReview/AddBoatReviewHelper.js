({
    onInit : function(component, event, helper) {
        component.find("service").getNewRecord('BoatReview__c', null, false, $A.getCallback(function(){
            var record = component.get("v.boatReview");
            var error = component.get("v.recordError");
            var boat = component.get("v.boat");
            if (error || record == null || boat == null){
                console.log('An error has occured');
            } else {
                component.set("v.boatReview.Boat__c", boat.Id);
            }
        }));

    }
})
