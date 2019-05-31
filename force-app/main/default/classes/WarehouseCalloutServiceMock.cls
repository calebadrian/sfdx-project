@isTest
global class WarehouseCalloutServiceMock implements HttpCalloutMock {
    global HttpResponse respond (HttpRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"_id":"55d66226726b611100aaf741", "replacement": false, "quantity": 5, "name": "Generator 1000 kW", "maintenanceperiod": 365, "lifespan": 120, "cost": 5000, "sku": "100003"},{"_id":"55d66226726b611100aaf763", "replacement": false, "quantity": 5, "name": "Generator 10000 kW", "maintenanceperiod": 365, "lifespan": 150, "cost": 6000, "sku": "200001"}]');
        response.setStatusCode(200);
        return response;
    }
}