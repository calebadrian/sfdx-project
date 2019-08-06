({
    onInit : function(component, event, helper) {
        var action = component.get('c.getAll');
        action.setParams({
            boatId: component.get('v.boat').Id
        });
        action.setCallback(function(response){
            if(response.getState() == 'SUCCESS'){
                component.set('v.boatReviews', response.getReturnValue());
            } else if (response.getState() == 'ERROR'){
                console.log("An error has occured");
            }
        });
        $A.enqueueAction(action);
    }
})
