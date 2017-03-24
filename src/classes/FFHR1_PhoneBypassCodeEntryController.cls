/***************************************************************************
// (c) 2015 Appirio, Inc.
//
// Description    : Phone Bypass Code Entry Controller class
//                  
// Sep 08, 2015   : Himshikha Agrawal         Original
//***************************************************************************/
public class FFHR1_PhoneBypassCodeEntryController{
    
    public FFHR1_Lead__c lead{get; set;}
    public String phoneNumber{get; set;}
    public Boolean displayByPass{get; set;}
    public Boolean displaySnap{get; set;}
    private String tryingAgain;
    private String campaignId;
    
    public FFHR1_PhoneBypassCodeEntryController(){
        system.debug('In Constructor');
        displaySnap = true;
        lead = new FFHR1_Lead__c();  
        //get campaign id from url params
        if(ApexPages.currentPage().getParameters().get('campaignId') != null) {
            campaignId = ApexPages.currentPage().getParameters().get('campaignId');
            //set campaign id to cookie
            FFHR1_CookieUtility.setCookie(FFHR1_CookieUtility.CAMPAIGNID,campaignId);
        } 
        //get bypasscode from url params 
        if(String.isNotBlank(ApexPages.currentPage().getParameters().get('bc'))) {
            lead.Bypass_Code__c = ApexPages.currentPage().getParameters().get('bc');
            FFHR1_CookieUtility.setCookie('bc',lead.Bypass_Code__c);
            displayByPass = false;
        }
        else
            displayByPass = true;
    }
    
    //user clicks on continue
    public void continueButton(){
        //PageReference pr;
        if(!String.isBlank(campaignId)){
            
            try{
                lead.First_Name__c = 'Mobile User';
                lead.Phone__c = phoneNumber;
                lead.Last_Name__c = lead.External_Id__c = getLeadExternalId(lead);
                upsert lead External_Id__c;
                
                
                FFHR1_Campaign_Member__c campaignMember = new FFHR1_Campaign_Member__c();
                campaignMember.Campaign__c = campaignId;
                campaignMember.Lead__c = lead.Id;
                campaignMember.External_Id__c = getLeadExternalId(lead) + '_' + campaignId;
                if(lead.Phone__c != null){
                    FFHR1_Phone_Number__c phoneNumber;
                    for(FFHR1_Phone_Number__c pNum : [select Id From FFHR1_Phone_Number__c Limit 1]){
                        campaignMember.Phone_Number__c = pNum.Id;
                    }
                }
                upsert campaignMember External_Id__c;
                FFHR1_CookieUtility.setCookie(FFHR1_CookieUtility.MEMBERID,campaignMember.Id);

                tryingAgain = ApexPages.currentPage().getParameters().get('tryingAgain');
                if(tryingAgain != 'true'){
                    //increment the total hits on Campaign
                    FFHR1_Campaign__c campaign = [Select Total_Hits_1__c from FFHR1_Campaign__c where id =: campaignId limit 1][0];
                    if(campaign.Total_Hits_1__c != null)
                        campaign.Total_Hits_1__c++;
                    else
                        campaign.Total_Hits_1__c = 1;
                    update campaign;
                }
                               
            } catch(Exception e){}
        }
        else {
            System.debug('Error');
            displaySnap = false;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'The system is unable to process the request. Please contact the system administrator.'));
            //return null;
        }
    }
    
    private String getLeadExternalId(FFHR1_Lead__c memberLead){
        if(memberLead.Phone__c != null && memberLead.Phone__c != ''){
            return memberLead.Phone__c;
        }
        if(memberLead.Email__c != null && memberLead.Email__c != ''){
            return memberLead.Email__c;
        }
        return '';
    }

    
    //method for Try Againg button
    public PageReference getTryAgain(){
        return new PageReference('FFHR1_PhoneBypassCodeEntryPage?tryingAgain=true&campaignId=' + FFHR1_CookieUtility.getCookie(FFHR1_CookieUtility.CAMPAIGNID) + '&bc=' + FFHR1_CookieUtility.getCookie('bc'));
    }

}