({
    onBoatClick: function(component, event, helper){
        var appEvent = component.getEvent('boatSelect');
        var appEvent1 = $A.get('e.c:BoatSelected');
        appEvent1.setParams({
            boat: component.get('v.boat')
        })
        appEvent.setParams({
            boatId: component.get("v.boat").Id
        })
        appEvent.fire();
        appEvent1.fire();
    }
})
