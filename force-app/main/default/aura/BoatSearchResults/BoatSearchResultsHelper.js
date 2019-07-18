({
    onSearch: function(component){
        var action = component.get('c.getBoats');
        action.setParams({
            boatTypeId: ''
        })
        action.setCallback(this, function(response){
            
        })
        $A.enqueueAction(action);
    }
})