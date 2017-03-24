@isTest
public class FFHR1_RedemptionController_Test {

    @isTest public static void testMethod1() {
        // Campaign With which members need to be associated
        FFHR1_Campaign__c testCampaign = new FFHR1_Campaign__c(Name='TestCampaign',
                                                               Redemption_Center__c='TestURl.com',
                                                               Require_Selfie__c=false,
                                                               Survey_URL__c='testurl.com',
                                                               Total_Hits_1__c=10);
        insert testCampaign;    
        // Lead for Campaign Member                                                           
        FFHR1_Lead__c testLead = new FFHR1_Lead__c(Name='ÇampaignLead',
                                         Bypass_Code__c='TestBypass',
                                         Phone__c ='9898989898',
                                         First_Name__c='FirstName',
                                         Last_Name__c='LastName',
                                         Source__c='TestSource');
        insert testLead; 
        // Phone Number For CampaignMember     
        FFHR1_Phone_Number__c testNumber = new FFHR1_Phone_Number__c(Country_Code__c='91',
                                                                     Name='TestPhone',
                                                                     Number__c='8478475874');
        insert testNumber; 
        
        // Insert Campaign                                                                    
        FFHR1_Campaign_Member__c campMember= new FFHR1_Campaign_Member__c(Lead__c=testLead.Id,
                                                                                 Campaign__c=testCampaign.Id,
                                                                                 SendMessage__c=true,
                                                                                 Status__c = 'Not Rewarded',
                                                                                 Phone_Number__c=testNumber.Id);
                                                               
        insert campMember;
        //Page.setPageReference(Pages.FFHR1_PhoneBypassCodeEntryPage);
        //ApexPages.currentPage().getParameters().get('memberId');
        Test.startTest();
        ApexPages.currentPage().getParameters().put('memberId',campMember.Id) ;
        FFHR1_RedemptionController cltr = new FFHR1_RedemptionController();
        cltr.getLocation();
        cltr.updateRedeemCode();
        Test.stopTest();
        
    }
    
     @isTest public static void testMethod2() {
        // Campaign With which members need to be associated
        FFHR1_Campaign__c testCampaign = new FFHR1_Campaign__c(Name='TestCampaign',
                                                               Redemption_Center__c='TestURl.com',
                                                               Require_Selfie__c=false,
                                                               Survey_URL__c='testurl.com',
                                                               Total_Hits_1__c=10);
        insert testCampaign;    
        // Lead for Campaign Member                                                           
        FFHR1_Lead__c testLead = new FFHR1_Lead__c(Name='ÇampaignLead',
                                         Bypass_Code__c='TestBypass',
                                         Phone__c ='9898989898',
                                         First_Name__c='FirstName',
                                         Last_Name__c='LastName',
                                         Source__c='TestSource');
        insert testLead; 
        // Phone Number For CampaignMember     
        FFHR1_Phone_Number__c testNumber = new FFHR1_Phone_Number__c(Country_Code__c='91',
                                                                     Name='TestPhone',
                                                                     Number__c='8478475874');
        insert testNumber; 
        
        // Insert Campaign                                                                    
        FFHR1_Campaign_Member__c campMember= new FFHR1_Campaign_Member__c(Lead__c=testLead.Id,
                                                                                 Campaign__c=testCampaign.Id,
                                                                                 SendMessage__c=true,
                                                                                 Status__c = 'Not Rewarded',
                                                                                 Phone_Number__c=testNumber.Id);
        insert campMember;
        FFHR1_Redemption_Code__c redCode = new FFHR1_Redemption_Code__c(Campaign_Member__c = campMember.Id , Redeemed__c=false); 
        insert redCode;
                                                                                
        
        //Page.setPageReference(Pages.FFHR1_PhoneBypassCodeEntryPage);
        //ApexPages.currentPage().getParameters().get('memberId');
        Test.startTest();
        ApexPages.currentPage().getParameters().put('memberId',campMember.Id) ;
        FFHR1_RedemptionController cltr = new FFHR1_RedemptionController();
        cltr.getLocation();
        cltr.updateRedeemCode();
        Test.stopTest();
        
    }
    
   }