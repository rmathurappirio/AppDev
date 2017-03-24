//
// (c) 2015 Appirio, Inc.
//
// Rest API to check Contacs and Leads for email passesed in Request parameter.
//
// 10 Sep 2015 Rohit Mathur Original
//
    
@RestResource(urlMapping='/mediafly/saleskit/verifyemail/*')
global class EmailCheck {
    
    @HttpGet
    
    // Returns true if "email" passsed in parameter exists in Contact or Leads
    // else create the contact with "lastname" , "firstname" passed in parameter.
    // @param email a URL parameter
    // @param firstname a URL parameter
    // @param lastname a URL parameter
    // @param ischeckonly a URL parameter
    // @return "true" if email id already exists
    // @return "id" of contact inserted.

    global static String checkRecords() 
    {
        String paramEmail = RestContext.request.params.get('email');
        String paramFirstName = RestContext.request.params.get('firstname');
        String paramLastName = RestContext.request.params.get('lastname');
        String paramIsCheck =  RestContext.request.params.get('ischeckonly');
        List<Contact> conList;
        list<Lead> leadList;
        
        if(paramEmail != null && paramEmail != ''){
            conList = [select id,Email from Contact where Email =: paramEmail ];
            leadList = [select id, Email from Lead where Email =: paramEmail ];
            
            if((conList.size() != 0 || leadList.size() !=0) && paramIsCheck.equalsIgnoreCase('true')){
            return 'Success' ; 
            }
            else if((conList.size() != 0 || leadList.size() !=0) && paramIsCheck.equalsIgnoreCase('false')){            
                return 'Success';
            }else if((conList.size() == 0 || leadList.size() ==0) && paramIsCheck.equalsIgnoreCase('true')){
                return 'Fail';
            }
            else if((conList.size() == 0 || leadList.size() ==0) && paramIsCheck.equalsIgnoreCase('false')){
                if((paramFirstName != null || paramFirstName != '') && (paramLastName != null || paramLastName != '') &&  (paramEmail  != null || paramEmail != '')){
                    
                    Lead newLead = new Lead(lastname=paramLastName , firstname = paramFirstName ,Email = paramEmail ,  company= paramFirstName+paramLastName , LeadSource = '3rd Party Calling' , Industry = 'Other' );
                    insert newLead;
                    
                    return 'Success';
                }
            }
        }else{
            return 'Fail';
        }
        return 'Fail';
    }
}