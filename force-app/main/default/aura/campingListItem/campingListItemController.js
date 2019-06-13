({
    packItem : function(component, event, helper) {
        var item = component.get('v.item');
        item.Packed__c = true;
        event.getSource().set('v.disabled', true);
    }
})