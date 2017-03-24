/***************************************************************************
// (c) 2015 Appirio, Inc.
//
// Description    : Test Class For FFHR1_CookieUtility
//                  
// Oct 06, 2015   : Ravindra Shekhawat         Original
//***************************************************************************/
@isTest
private class FFHR1_CookieUtilityTest {

    static testMethod void myUnitTest() {
      Test.startTest();
        // Set Cookie
        FFHR1_CookieUtility.setCookie('Name','TestCookie');
        System.assertEquals(FFHR1_CookieUtility.getCookie('Name'),'TestCookie');
        System.assertEquals(FFHR1_CookieUtility.getCookie('Null'),'');
    	Test.stopTest();
    }
}