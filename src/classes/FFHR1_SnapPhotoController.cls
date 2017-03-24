/***************************************************************************
// (c) 2015 Appirio, Inc.
//
// Description    : Snap Photo Controller class
//                  
// Sep 11, 2015   : Himshikha Agrawal         Original
//***************************************************************************/
public with sharing class FFHR1_SnapPhotoController {
    
    public Attachment attachment {get; set;}
    private FFHR1_Campaign_Member__c currentCampaignMember;
    
    public FFHR1_SnapPhotoController(){
        Id cmId = ApexPages.currentPage().getParameters().get('memberId');
        for(FFHR1_Campaign_Member__c cempaignMember : [Select Id,Lead__c, Campaign__r.Survey_URL__c from FFHR1_Campaign_Member__c where Id =: cmId]){
            currentCampaignMember = cempaignMember;
        }
        FFHR1_CookieUtility.setCookie(FFHR1_CookieUtility.MEMBERID,cmId);
        attachment = new Attachment();
        
        
    }
    
    public PageReference saveAttachment(){
        
        attachment.Description = 'Selfie Images';
        try {
            FFHR1_Lead_Assets__c leadAsset = new FFHR1_Lead_Assets__c();
            //creating a lead asset
            leadAsset.recordTypeId = Schema.SObjectType.FFHR1_Lead_Assets__c.getRecordTypeInfosByName().get('Upload').getRecordTypeId();
            
            leadAsset.Lead__c = currentCampaignMember.Lead__c;
            leadAsset.Type__c = 'Selfie';
            insert leadAsset;
            
            attachment.ParentId = leadAsset.Id; // the record the file is attached to
            insert attachment;
            return continueMethod();
            
        } catch (DMLException e) {
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
        } finally {
          attachment = new Attachment(); 
        }
        return null;
        
  }
    
    //method for Selfie Capture Continue
    public PageReference continueMethod(){
        return new PageReference(currentCampaignMember.Campaign__r.Survey_URL__c + '?memberId=' + currentCampaignMember.Id);
    }

}