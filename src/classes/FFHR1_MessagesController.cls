public without sharing class FFHR1_MessagesController {
    public FFHR1_MessagesController(){
        //sendTextMessage('+919166274492');
    }
    
    public static String sendTextMessage(String fromNumber, String toNumber, String textMessage){
        TwilioRestClient client = new TwilioRestClient(Label.Twillo_Account_Id, Label.Twillo_Account_Token);
        Map<String,String> params = new Map<String,String> {
                //'To'   => '+447740174635',
                //'From' => '+441483802583',
                'To'   => toNumber,
                'From' => fromNumber,
                'Body' => textMessage
            };
            
        TwilioMessage message ;
        if(!Test.isRunningTest())
        message = client.getAccount().getMessages().create(params);
        //system.debug('====' + message);
        //system.debug('====' + message.getProperty('message')); 
        return message!= null ? message.getProperty('message') : null;   
    }
    
    public static String sendEmailMessage(String toEmailAddress, String textMessage){
    
        try{
    
           OrgWideEmailAddress owe = [SELECT ID,IsAllowAllProfiles,DisplayName,Address FROM OrgWideEmailAddress WHERE IsAllowAllProfiles = TRUE LIMIT 1];
            
    
        
           Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
           message.setToAddresses(new String[] { toEmailAddress});
           message.setPlainTextBody(textMessage);
           message.setSubject('Next Step From Event Scout');
           message.setOrgWideEmailAddressId(owe.Id);
           Messaging.SingleEmailMessage[] messages = new Messaging.SingleEmailMessage[]{ message };
           Messaging.sendEmail(messages);

        
        }catch(Exception ex){
            return ex.getMessage();
        } 
        return null;   
    }
    
    // calling a future method for invoking the web service which will send the message if phone is available
    @future (callout=true)
    public static void sendTextMessageByFuture(String memberId, String textMessage){
        FFHR1_Campaign_Member__c member = new FFHR1_Campaign_Member__c(Id = memberId);
        for(FFHR1_Campaign_Member__c tempMember : [Select Id, Lead__r.Phone__c,Lead__r.Email__c,SendMessage__c,MessageSendingError__c,Phone_Number__r.Number__c
                                                    from FFHR1_Campaign_Member__c 
                                                    where Id =: memberId and Lead__c != null limit 1]){
            if(tempMember.SendMessage__c == true){
                //successfully message Sent
                if(tempMember.Lead__r.Phone__c != null){
                    String message = sendTextMessage(tempMember.Phone_Number__r.Number__c,tempMember.Lead__r.Phone__c, textMessage);
                    if(message ==  null){
                        member.SendMessage__c = false;
                        member.MessageSendingError__c = '';
                    }
                    //some error occured
                    else{
                        member.SendMessage__c = true;
                        member.MessageSendingError__c = message;
                    }
                }else if(tempMember.Lead__r.Email__c != null){
                    //to do send email 
                    String message = sendEmailMessage(tempMember.Lead__r.Email__c, textMessage);
                    if(message ==  null){
                        member.SendMessage__c = false;
                        member.MessageSendingError__c = '';
                    }
                    //some error occured
                    else{
                        member.SendMessage__c = true;
                        member.MessageSendingError__c = message;
                    }
                }
            }
        }
        
        update member;
    }

}

//in case of failure
//13:09:24:849 USER_DEBUG [16]|DEBUG|====TwilioMessage:[InstanceResource.properties={code=21612, message=The 'To' phone number: +919166274492, is not currently reachable using the 'From' phone number: +441483802583 via SMS., more_info=https://www.twilio.com/docs/errors/21612, status=400}, InstanceResource.uri=null, SID_PROPERTY=sid, TwilioResource.client=TwilioRestClient:[DEFAULT_VERSION=2010-04-01, VERSION=3.2.0, accountSid=ACec09f75fbb5ce2b893592462614e2065, authAccount=TwilioAccount:[ACCOUNT_SID_PROPERTY=sid, AUTH_TOKEN_PROPERTY=auth_token, CONNECT_APP_SID_PROPERTY=connect_app_sid, DATE_CREATED_PROPERTY=date_created, DATE_UPDATED_PROPERTY=date_updated, FRIENDLY_NAME_PROPERTY=friendly_name, InstanceResource.properties={auth_token=9339262a6659b7c966cbe72d9ea57521, sid=ACec09f75fbb5ce2b893592462614e2065}, InstanceResource.uri=null, OWNER_ACCOUNT_SID_PROPERTY=owner_account_sid, STATUS_PROPERTY=status, TYPE_PROPERTY=type, TwilioResource.client=(already output), TwilioResource.filters=null, TwilioResource.loaded=false, TwilioResource.requestAccountSid=ACec09f75fbb5ce2b893592462614e2065], authToken=9339262a6659b7c966cbe72d9ea57521, endpoint=https://api.twilio.com, numRetries=3], TwilioResource.filters=null, TwilioResource.loaded=true, TwilioResource.requestAccountSid=null]

//in case of success
//13:10:32:829 USER_DEBUG [16]|DEBUG|====TwilioMessage:[InstanceResource.properties={account_sid=ACec09f75fbb5ce2b893592462614e2065, api_version=2010-04-01, body=Hello Text Message!, date_created=Mon, 18 May 2015 07:40:33 +0000, date_sent=null, date_updated=Mon, 18 May 2015 07:40:33 +0000, direction=outbound-api, error_code=null, error_message=null, from=+441483802583, ...}, InstanceResource.uri=null, SID_PROPERTY=sid, TwilioResource.client=TwilioRestClient:[DEFAULT_VERSION=2010-04-01, VERSION=3.2.0, accountSid=ACec09f75fbb5ce2b893592462614e2065, authAccount=TwilioAccount:[ACCOUNT_SID_PROPERTY=sid, AUTH_TOKEN_PROPERTY=auth_token, CONNECT_APP_SID_PROPERTY=connect_app_sid, DATE_CREATED_PROPERTY=date_created, DATE_UPDATED_PROPERTY=date_updated, FRIENDLY_NAME_PROPERTY=friendly_name, InstanceResource.properties={auth_token=9339262a6659b7c966cbe72d9ea57521, sid=ACec09f75fbb5ce2b893592462614e2065}, InstanceResource.uri=null, OWNER_ACCOUNT_SID_PROPERTY=owner_account_sid, STATUS_PROPERTY=status, TYPE_PROPERTY=type, TwilioResource.client=(already output), TwilioResource.filters=null, TwilioResource.loaded=false, TwilioResource.requestAccountSid=ACec09f75fbb5ce2b893592462614e2065], authToken=9339262a6659b7c966cbe72d9ea57521, endpoint=https://api.twilio.com, numRetries=3], TwilioResource.filters=null, TwilioResource.loaded=true, TwilioResource.requestAccountSid=null]