public class Auth1{
    public String Akey{get;set;}
       
    public Auth1()
    {
       
    }
    
    public PageReference myMethod()
    {    
        String code= apexpages.currentpage().getparameters().get('code');
        String orgid = UserInfo.getOrganizationId();
        System.debug('@@key ' + apexpages.currentpage().getparameters().get('code'));
        System.debug('@@Org id ' + UserInfo.getOrganizationId());
        /*PageReference newPage = page.Authpage;
        newPage.getParameters().put('Code', key);
        newPage.getParameters().put('orgid', orgid);
        */
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token?code='+code+'&grant_type=authorization_code&client_id=3MVG9Y6d_Btp4xp7nDYlO.lkYyRmKPNCPi4h0tTpaa2nw8KxJQR28CViKxtwWXR.qLA9H1tHKNQgXVpwnxas.&client_secret=4690697650995926958&redirect_uri=https://rmrohit963-dev-ed--c.ap1.visual.force.com/apex/HelloWorld');
        req.setMethod('GET');
        res=http.send(req);
        System.debug('<<<<>>>>>'+res.getBody());
        return null;
       
        
     }
}