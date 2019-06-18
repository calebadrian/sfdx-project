({
    createItem: function(component, event){
        var action = component.get('c.saveItem');
        action.setParams({
            newItem: component.get('v.newItem')
        })
        action.setCallback(this, function(response){
            if (response.getState() === 'SUCCESS'){
                var items = component.get('v.items');
                items.push(response.getReturnValue());
                component.set('v.items', items);
            }
        })
        $A.enqueueAction(action);
    }
})