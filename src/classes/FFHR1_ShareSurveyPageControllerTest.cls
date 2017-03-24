/***************************************************************************
// (c) 2015 Appirio, Inc.
//
// Description    : Test Class For FFHR1_ShareSurveyPageController
//                  
// Oct 06, 2015   : Ravindra Shekhawat         Original
//***************************************************************************/
@isTest
private class FFHR1_ShareSurveyPageControllerTest {

    static testMethod void myUnitTest() {
       // Campaign With which members need to be associated
        FFHR1_Campaign__c testCampaign = new FFHR1_Campaign__c(Name='TestCampaign',
        																											 Redemption_Center__c='TestURl.com',
        																											 Require_Selfie__c=false,
        																											 Survey_URL__c='testurl.com',
        																											 Total_Hits_1__c=10);
        Test.startTest();
        
        	FFHR1_CookieUtility.setCookie('campaignId',testCampaign.Id);
        	FFHR1_ShareSurveyPageController controller = new FFHR1_ShareSurveyPageController();
        	System.assertEquals(controller.campaignId,testCampaign.Id);
        	        																											 
    		Test.stopTest();
    }
}