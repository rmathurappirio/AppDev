/**=====================================================================
 * Appirio, Inc
 * Name: FullForceRegistrationHandler  
 * Description: Handler Class To login with Google
 * Created Date: [04/08/2015]
 * Created By: [Pankaj] (Appirio)
 * 
 * Date Modified                Modified By                  Description of the update
 * [MON DD, YYYY]               [FirstName LastName]         [Short description for changes]
 =====================================================================*/

global class FFHR1_FullForceRegistrationHandlerApp1 implements Auth.RegistrationHandler{
global User createUser(Id portalId, Auth.UserData data){
    System.debug('calling future');
    
    String jsonString = '{"Email":"'+data.email+'","FirstName":"'+data.firstName+'","Lastname":"'+data.lastName+'","Provider":"'+data.provider+'"}';
    Blob b = Blob.valueOf(jsonString);
    String base64 = EncodingUtil.base64Encode(b);
    //createLeadFuture(data.email,data.firstName,data.lastName,data.provider);
    System.debug('Done future');
    throw new HandlerException(base64);
    return null;
  }
  
  
  
  //custom exception
  global class HandlerException extends Exception{}

  global void updateUser(Id userId, Id portalId, Auth.UserData data){ 
    System.debug('calling future');
    
    String jsonString = '{"Email":"'+data.email+'","FirstName":"'+data.firstName+'","Lastname":"'+data.lastName+'","Provider":"'+data.provider+'"}';
    Blob b = Blob.valueOf(jsonString);
    String base64 = EncodingUtil.base64Encode(b);
    //createLeadFuture(data.email,data.firstName,data.lastName,data.provider);
    System.debug('Done future');
    throw new HandlerException(base64);
  }

}