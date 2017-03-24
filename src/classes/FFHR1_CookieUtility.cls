/***************************************************************************
// (c) 2015 Appirio, Inc.
//
// Description    : Phone Bypass Code Entry Controller class
//                  
// Sep 08, 2015   : Himshikha Agrawal         Original
//***************************************************************************/
public class FFHR1_CookieUtility{

    public final static string MEMBERID = 'memberId';
    public final static string CAMPAIGNID = 'campaignId';
    public static string getCookie(String key){
        Cookie obj = ApexPages.currentPage().getCookies().get(key);
        if(obj != null){
            return obj.getValue();
        }
        return '';
    }
    
    
    public static void setCookie(String key , String value){
        Cookie obj = new Cookie(key,value ,null,-1,false);
        ApexPages.currentPage().setCookies(new Cookie[]{obj});
    }

}