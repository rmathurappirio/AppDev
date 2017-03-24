trigger alert_e on Society__c (after insert) {
   
    //for(Society__c soc : Trigger.New)
    {
       email_alert ea = new email_alert();
       ea.alert(trigger.new);
    }
     
}