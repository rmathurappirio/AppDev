public class email_alert {
    List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
    public void alert(List <Society__C> soclist)
    {
        for(Society__c soc : soclist)
    {
        if(Society__c.Name != null)
        {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] sendto = new String[]{'rmrohit963@gmail.com'};            
            mail.setToAddresses(sendto);
            mail.setSenderDisplayName('Salesforce India pvt. Ltd.');
            mail.SetSubject('Alter for new society creation');
            
            //User u = New User();
            String body = 'Dear '+UserInfo.getName()+' ,<br> ';
          body += 'This is to inform you that a new society '+Soc.Name+' has been created.<br>';
          body += 'We hereby invite you to kindly give presence at the society inaugural.<br><br><br>';
          body += '<br>Thanking you,<br>Admin.';
      
            mail.setHtmlBody(body);
            
            mails.add(mail);
         }
     }
     Messaging.SendEmail(mails);
    }
}