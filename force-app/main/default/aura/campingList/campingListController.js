({
    doInit : function(component, event, helper) {
        var action = component.get('c.getItems');
        action.setCallback(this, function(response){
            if (response.getState() === 'SUCCESS'){
                component.set('v.items', reponse.getReturnValue());
            }
        })
        $A.enqueueAction(action);
    },
    handleAddItem: function(component, event, helper){
        var action = component.get('c.saveItem');
        var param = event.getParam('c.item');
        action.setParams({
            newItem: param
        });
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                var items = component.get('v.items');
                items.push(response.getReturnValue());
                component.set('v.items', items);
            }
        })
        $A.enqueueAction(action);
    }
})