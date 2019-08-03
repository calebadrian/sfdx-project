({
    doInit : function(component, event, helper) {
        helper.onInit(component, event, helper);
    },
    onRecordUpdated : function(component, event, helper){

    },
    onSave : function(component, event, helper){
        component.find("service").saveRecord(function(result){
            if (result.state == 'SUCCESS'){
                var resultToast = $A.get("e.force:showToast");
                if (resultToast){
                    resultToast.setParams({
                        title: "Saved",
                        message: "Boat Review Created"
                    });
                } else {
                    alert("Boat Review Created");
                }
            } else if (result.state == 'ERROR'){
                var errorMessage = '';
                for (var i = 0; i < result.error.length; i++){
                    errorMessage += result.error[i].message + "\n";
                }
                component.set("v.recordError", errorMessage);
            }
            var boatReviewAddedEvent = component.getEvent("boatReviewAdded");
            boatReviewAddedEvent.fire();
            helper.onInit(component, event, helper);
        })
    }
})
