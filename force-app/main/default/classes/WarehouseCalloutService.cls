public with sharing class WarehouseCalloutService {
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @future (callout = true)
    public static void runWarehouseEquipmentSync(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200){
            List <EquipmentWrapper> allEquipment = (List <EquipmentWrapper>) JSON.deserialize(response.getBody(), List <EquipmentWrapper>.class);
            List <Product2> allProducts = [SELECT Id, Cost__c, Current_Inventory__c, Lifespan_Months__c, Maintenance_Cycle__c, Replacement_Part__c, Warehouse_SKU__c, Name FROM Product2];
            List <Product2> updatedProducts = new List <Product2>();
            for (EquipmentWrapper eW : allEquipment){
                Boolean found = false;
                for (Product2 pro : allProducts){
                    if (pro.Warehouse_SKU__c == eW.sku){
                        found = true;
                        pro.Replacement_Part__c = eW.replacement;
                        pro.Current_Inventory__c = eW.quantity;
                        pro.Name = eW.name;
                        pro.Maintenance_Cycle__c = eW.maintenanceperiod;
                        pro.Lifespan_Months__c = eW.lifespan;
                        pro.Cost__c = eW.cost;
                        Integer testLine = 2;
                        updatedProducts.add(pro);
                    }
                }
                if (!found){
                    Product2 newProduct = new Product2();
                    newProduct.Replacement_Part__c = eW.replacement;
                    newProduct.Current_Inventory__c = eW.quantity;
                    newProduct.Name = eW.name;
                    newProduct.Maintenance_Cycle__c = eW.maintenanceperiod;
                    newProduct.Lifespan_Months__c = eW.lifespan;
                    newProduct.Cost__c = eW.cost;
                    newProduct.Warehouse_SKU__c = eW.sku;
                    updatedProducts.add(newProduct);
                }
            }
            upsert updatedProducts;
        }
    }
}