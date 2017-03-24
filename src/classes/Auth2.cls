public class Auth2{
    public String resp {get;set;}
    public String myString {get;set;}
    public Auth2(){
      Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint('https://rmrohit963-dev-ed.my.salesforce.com/services/apexrest/mediafly/saleskit/verifyemail?firstname=Rohit&lastname=Test&email=test@rohittest.com&ischeckonly=false');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization','Bearer '+myString);
        req.setMethod('GET');
        res=http.send(req);
        resp = res.getBody();
    }


    public PageReference myMethod()
    {
        System.debug(myString);
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint('https://rmrohit963-dev-ed.my.salesforce.com/services/apexrest/mediafly/saleskit/verifyemail?firstname=Rohit&lastname=Test&email=test@rohittest.com&ischeckonly=false');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization','Bearer '+myString);
        req.setMethod('GET');
        res=http.send(req);
        resp = res.getBody();
        return null;
    }
 }