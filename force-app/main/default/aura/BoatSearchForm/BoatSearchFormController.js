({
    doInit : function(component, event, helper) {
        var isEnabled = $A.get("event.force:createRecord");
        component.set('v.createEnabled', isEnabled);
        helper.doInit(component, event);
    },
    newBoatType: function(component, event, helper){
        var createBoatEvent = $A.get('e.force:createRecord');
        createBoatEvent.setParams({
            'entityApiName' : 'Boat__c',
            'defaultFieldValues' : {

            }
        });
        createBoatEvent.fire();
    }
})