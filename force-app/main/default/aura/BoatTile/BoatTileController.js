({
    onBoatClick: function(component, event, helper){
        var appEvent = component.getEvent('boatSelect');
        appEvent.setParams({
            boatId: component.get("v.boat").Id
        })
        appEvent.fire();
    }
})
