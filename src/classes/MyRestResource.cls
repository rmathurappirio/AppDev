@RestResource(URLMapping='/MyResource/*')
global with sharing class MyRestResource{
   
    @HttpGET
    global static Map<String,List<String>> orgDetails(){
        Integer count = 0;
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();
        List<String> objectList = new List<String>();
        List<String> fieldNames = new List<String>();
        Map<String,List<String>> fieldList = new Map<String,List<String>>();
        for(Schema.SobjectType obj : gd){
            objectList.add(obj.getDescribe().getName());
        }
        for(String objName : objectList){      
            SObjectType objToken = Schema.getGlobalDescribe().get(objName);
            if(objToken!=null && objName.contains('__c')){
                DescribeSObjectResult objDef = objToken.getDescribe();
                Map<String, SObjectField> fields = objDef.fields.getMap();
                
                Set<String> fieldSet = fields.keySet();
                for(String s:fieldSet)
                {
                    SObjectField fieldToken = fields.get(s);
                    DescribeFieldResult selectedField = fieldToken.getDescribe();
                    fieldNames.add(selectedField.getName());
                }
             }
             fieldList.put(objName,fieldNames);
         }
         System.debug(fieldList);
         return fieldList;
    }
}