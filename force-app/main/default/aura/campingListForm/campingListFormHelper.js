({
    createItem: function(component, event){
        var eve = component.getEvent('addItem');
        eve.setParams({"item": component.get('v.newItem')});
        eve.fire();
        component.set('v.newItem', {'sobjectType' : 'Camping_Item__c',
        'Name': '', 'Price__c': 0, 'Quantity__c': 0, 'Packed__c': false});
    }
})
