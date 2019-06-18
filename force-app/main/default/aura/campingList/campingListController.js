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
    clickCreateItem : function(component, event, helper){
        var validItem = component.find('itemform').reduce(function(validSoFar, inputCmp){
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        })
        if (validItem){
            helper.createItem(component, event);
            component.set('v.newItem', {'sobjectType' : 'Camping_Item__c',
            'Name': '', 'Price__c': 0, 'Quantity__c': 0, 'Packed__c': false});
        }
    }
})