public class udaictrl{
    Public list<Account> accountlist {get;set;}
    public Map<id,Authorisation__c> autList {get;set;}
    
    public udaictrl(){
        accountlist = new list<Account>();
        autList  = new Map<id,Authorisation__c>();
        
        accountlist  = [select Id, Name,(Select Id, Name from Authorisations__r) from Account where Name Like '%Mathur%'];
        if(accountlist.size() > 0){
            for(Account acc : accountlist){
                if(acc.Authorisations__r != null && acc.Authorisations__r.size() > 0){
                    for(Authorisation__c auth : acc.Authorisations__r){
                        autList.put(acc.id,auth);
                    }
                }
            }
        }
    }

}