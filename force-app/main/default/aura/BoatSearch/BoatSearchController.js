({
    myAction : function(component, event, helper) {

    },
    onFormSubmit: function(component, event, helper){
       
    },
    search: function(component, event, helper){
        var formData = event.getParams('formData');
        component.set('v.boatTypeId', formData.boatTypeId);
        helper.onSearch(component);
    }
})