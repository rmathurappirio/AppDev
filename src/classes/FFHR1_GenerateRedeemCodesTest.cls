/***************************************************************************
// (c) 2015 Appirio, Inc.
//
// Description    : Test Class For FFHR1_GenerateRedeemCodes
//                  
// Oct 06, 2015   : Ravindra Shekhawat         Original
//***************************************************************************/
@isTest
private class FFHR1_GenerateRedeemCodesTest {

    static testMethod void myUnitTest() {
       Test.startTest();
       		FFHR1_GenerateRedeemCodes redeemCodeGenerator = new FFHR1_GenerateRedeemCodes();
       		FFHR1_GenerateRedeemCodes.insertCodes(5);
       		List<FFHR1_Redemption_Code__c> codesList = [SELECT Id,Name FROM FFHR1_Redemption_Code__c];
       		System.assert(codesList!=null);
       		System.assertEquals(codesList.size(),5);
       Test.stopTest();
       
    }
}