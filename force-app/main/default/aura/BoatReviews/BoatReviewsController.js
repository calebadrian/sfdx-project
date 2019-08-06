({
    doInit : function(component, event, helper) {
        helper.onInit(component, event, helper);
    },
    onUserInfoClick: function(component, event, helper){
        var userId = event.currentTarget.getAttribute('data-userid');
        var nav = $A.get('e.force:navigateToSObject');
        nav.setParams({
            recordId: userId
        });
        nav.fire();
    },
})
