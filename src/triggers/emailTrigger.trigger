trigger emailTrigger on EmailMessage (before insert) {
    for(EmailMessage eMessage : trigger.new){
        eMessage.TextBody ='Thanks and regards';
        system.debug(eMessage.TextBody);
    }

}