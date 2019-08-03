({
    myAction : function(component, event, helper) {

    },
    onBoatSelected: function(component, event, helper){
        component.set('v.id', event.getParam('boat').Id);
        component.find('service').reloadRecord();
    },
    onRecordUpdated: function(component, event, helper){
        
    },
    onBoatReviewAdded: function(component, event, helper){
        component.set("v.selectedTabId", "boatreviewtab");
    }
})
