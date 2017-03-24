public with sharing class society_ext {

    private final society__c soc;
    public society_ext(ApexPages.StandardController controller) {
    
    
    this.soc= (society__c)controller.getRecord();
   // Integer i= select max(registration_number__c) from society__c 

        AggregateResult[] groupedResults = [select MAX(registration_number__c) maxval from society__c];
        //Integer max = [select MAX(registration_number__c) from society__c];

      object max= groupedResults[0].get('maxval');
      Decimal maxvalue= (Decimal)max +1 ;
      soc.registration_number__c= maxvalue;

    }
    
    


}