({
    onBoatClick: function(component, event, helper){
        var appEvent = component.getEvent('boatSelect');
        var appEvent1 = $A.get('e.c:BoatSelected');
        var boat = component.get('v.boat');
        appEvent1.setParams({
            boat: boat
        })
        appEvent.setParams({
            boatId: boat.Id
        })
        appEvent.fire();
        appEvent1.fire();
        var appEvent2 = $A.get('e.c:PlotMapMarker');
        appEvent2.setParams({
            lat: boat.Geolocation__Latitude__s,
            sObjectId: boat.Id,
            long: boat.Geolocation__Longitude__s,
            label: boat.Name
        });
        appEvent2.fire();
    }
})
