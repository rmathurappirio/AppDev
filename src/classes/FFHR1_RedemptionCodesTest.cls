/***************************************************************************
// (c) 2015 Appirio, Inc.
//
// Description    : Test Class For FFHR1_RedemptionCodes
//                  
// Oct 06, 2015   : Ravindra Shekhawat         Original
//***************************************************************************/
@isTest
private class FFHR1_RedemptionCodesTest {

    static testMethod void myUnitTest() {
        FFHR1_Phone_Number__c testNumber = new FFHR1_Phone_Number__c(Country_Code__c='91',
                                                                     Name='TestPhone',
                                                                     Number__c='8478475874');
        insert testNumber;
        Test.startTest();
        	FFHR1_RedemptionCodes controller = new FFHR1_RedemptionCodes(new ApexPages.StandardController(testNumber));
        	System.assertEquals(controller.getRecordName().containsIgnoreCase('TestPhone'),true);
        Test.stopTest();                                                                     
    }
}