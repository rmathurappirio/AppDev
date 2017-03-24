/***************************************************************************
// (c) 2015 Appirio, Inc.
//
// Description    : Phone Bypass Code Entry Controller class
//                  
// Sep 08, 2015   : Himshikha Agrawal         Original
//***************************************************************************/

public with sharing class FFHR1_SurveyIdentityLocationController {
    
    
    public boolean isSuccess {get;set;}
    public String message {get;set;}
    public Boolean identityConfirmed {get;set;}
    public Boolean verificationcomplete {get;set;}
    public String memberId {get;set;} 
    
    public FFHR1_SurveyIdentityLocationController(){
        identityConfirmed = false;
        verificationcomplete = false;
        memberId = FFHR1_CookieUtility.getCookie(FFHR1_CookieUtility.MEMBERID);
        if(memberId == null && ApexPages.currentPage().getParameters().get('memberId') != null) {
            memberId = ApexPages.currentPage().getParameters().get('memberId') ;
            FFHR1_CookieUtility.setCookie(FFHR1_CookieUtility.MEMBERID,memberId);
        } 
        if(memberId != null){
           for(FFHR1_Campaign_Member__c member : [Select Status__c From FFHR1_Campaign_Member__c Where Id =:memberId]){
              if(member.Status__c == 'Eligible'){
               identityConfirmed = true;
              }
            }
         }
        if(ApexPages.currentPage().getParameters().get('verificationcomplete') != null) {
            verificationcomplete = true;
        } 
    }
    
    public Pagereference createLead() {
        String base64String = ApexPages.currentPage().getParameters().get('ErrorDescription');
        String errorCode = ApexPages.currentPage().getParameters().get('ErrorCode');
        Pagereference pg;
        if(errorCode == 'REGISTRATION_HANDLER_ERROR') {
            // get params
            // base64String
            try {
            Blob b = EncodingUtil.base64Decode(base64String);
            String jsonString = b.toString();
            System.debug(jsonString);
            LeadData ldata = (LeadData)JSON.deserialize(jsonString,LeadData.class);
           
            memberId = FFHR1_CookieUtility.getCookie(FFHR1_CookieUtility.MEMBERID);
            
            FFHR1_Campaign_Member__c campaignMember ;
            for(FFHR1_Campaign_Member__c member : [Select Status__c, Lead__c From FFHR1_Campaign_Member__c Where Id =:memberId]){
              campaignMember = member;
            }
            
            Id leadAssetIdendityRecTypeId =  Schema.SObjectType.FFHR1_Lead_Assets__c.getRecordTypeInfosByName().get('Identity').getRecordTypeId();
            FFHR1_Lead_Assets__c leadAsset = new FFHR1_Lead_Assets__c(Lead__c = campaignMember.Lead__c,
                                                                      Type__c = ldata.Provider,
                                                                      recordTypeId = leadAssetIdendityRecTypeId);
            insert leadAsset; 
            
            campaignMember.Status__c = 'Eligible';
            update campaignMember;
            
            pg = Page.FFHR1_SurveyIdentityLocationPage;
            pg.getParameters().put('memberId',memberId);
            pg.getParameters().put('verificationcomplete','true');
            
            //system.assert(false,pg);
            isSuccess = true;
            } catch(Exception ex) { 
                message = ex.getMessage();
                isSuccess = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, message));
                return null;
            }
        }
        
        return pg;
    }
    
    public class LeadData {
        public String Email;
        public String Firstname;
        public String Lastname;
        public String Provider;
    }
}