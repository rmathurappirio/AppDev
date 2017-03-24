/***************************************************************************
// (c) 2015 Appirio, Inc.
//
// Description    : Phone Bypass Code Entry Controller class
//                  
// Sep 08, 2015   : Himshikha Agrawal         Original
//***************************************************************************/
public class FFHR1_ShareSurveyPageController{
    
    public String campaignId{get;set;}
    
    public FFHR1_ShareSurveyPageController(){
        campaignId = FFHR1_CookieUtility.getCookie(FFHR1_CookieUtility.CAMPAIGNID);
    }
}