({
    doInit : function(component, event) {
        var action = component.get('c.getTypeValues');
        action.setCallback(this, function(response){
            if (response.state == 'SUCCESS'){
                component.set('v.boatTypes', response.getReturnValue());
            }
        })
        $A.enqueueAction(action);
    }
})