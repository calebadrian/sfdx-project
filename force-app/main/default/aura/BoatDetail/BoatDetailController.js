({
    myAction : function(component, event, helper) {

    },
    onFullDetails: function(component, event, helper){
        var fullDetails = $A.get('e.force:navigateToSObject');
        fullDetails.setParams({
            recordId: component.get('v.boat.id')
        });
        fullDetails.fire();
    }
})
