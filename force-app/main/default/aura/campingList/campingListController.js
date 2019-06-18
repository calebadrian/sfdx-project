({
    myAction : function(component, event, helper) {

    },
    clickCreateItem : function(component, event, helper){
        var validItem = component.find('itemform').reduce(function(validSoFar, inputCmp){
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        })
        if (validItem){
            var items = component.get('v.items');
            items.push(component.get('v.newItem'));
            component.set('v.items', items);
            component.set('v.newItem', {'sobjectType' : 'Camping_Item__c',
            'Name': '', 'Price__c': 0, 'Quantity__c': 0, 'Packed__c': false});
        }
    }
})