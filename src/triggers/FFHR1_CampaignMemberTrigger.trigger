trigger FFHR1_CampaignMemberTrigger on FFHR1_Campaign_Member__c (after insert, after update, before insert, 
before update) {
    
    //if Outbound Sms gets updated any way then we need to send the message to Phone number stored int he camapaign member record
    if(Trigger.isBefore && Trigger.isUpdate && Trigger.new.size() == 1){
        for(FFHR1_Campaign_Member__c member : Trigger.new){
            if(member.MessageText__c != Trigger.oldMap.get(member.Id).MessageText__c){
                member.SendMessage__c = true;
                //future call to send Message
                FFHR1_MessagesController.sendTextMessageByFuture(member.Id, member.MessageText__c); 
            }
        }
        
    }
    
}