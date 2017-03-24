trigger WingCreate on Society__c (after insert) {
    List <Wing__c> newwing = new List<Wing__c>();
    for(Society__c soc : Trigger.new)
    {
        
       list <string> lp = new list <string>{'A','B','C'};
       for( String s : lp)
       {
           Wing__c w = new Wing__c();
           w.Name = s;
           w.Chairman__c= 'Vijay Mathur';
           w.Secretary__c= 'Vijay Mathur';
           w.Treasurer__c= 'Vijay Mathur';
           w.Society__c= soc.id;
          // w.Id= soc.Id;
           newwing.add(w);
        }
     }
     insert newwing;   
}