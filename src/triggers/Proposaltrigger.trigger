trigger Proposaltrigger on Opportunity (before insert) {
		string firsts = System.Userinfo.getFirstName();
		string lasts = System.Userinfo.getLastName();
		string userid = System.Userinfo.getUserId();
		string profilesettings = firsts+lasts+userid;
		Globals__c globalsettings = Globals__c.getValues(UserInfo.getOrganizationId());

List<ProposalTemplate__c> proposaltemplate = [select id, Name, Name__c, Terms_Paragraph__c, Introduction_Paragraph__c from ProposalTemplate__c where Name IN ('CompanySettings', :profilesettings)];

	for(Opportunity o : Trigger.new){
		for(ProposalTemplate__c p : proposaltemplate){
			if (p.Name == profilesettings && globalsettings.user_custom_settings__c == true) {
			o.Terms__c = p.Terms_Paragraph__c;
			o.Letter_Intro__c = p.Introduction_Paragraph__c;
			} 
			else if (p.Name == 'CompanySettings' && proposaltemplate.size() == 1 ){
			o.Terms__c = p.Terms_Paragraph__c;
			o.Letter_Intro__c = p.Introduction_Paragraph__c;
			}else if (p.Name == 'CompanySettings' && globalsettings.user_custom_settings__c == false) {
			o.Terms__c = p.Terms_Paragraph__c;
			o.Letter_Intro__c = p.Introduction_Paragraph__c;
			}
			else{
			
			
			}
		

		}

	}
}