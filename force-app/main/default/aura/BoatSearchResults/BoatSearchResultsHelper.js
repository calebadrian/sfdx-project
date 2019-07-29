({
    onSearch: function(component){
        var boatTypeId = component.get('v.boatTypeId');
        var action = component.get('c.getBoats');
        action.setParams({
            boatTypeId: boatTypeId
        })
        action.setCallback(this, function(response){
            
        })
        $A.enqueueAction(action);
    }
})