/***************************************************************************
// (c) 2015 Appirio, Inc.
//
// Description    : Redeem Reward Controller. The controller contains logic to
//					display a redemption code after user completes a survey.
//					The redemption code is not redeemable once user clicks on 
//					'Take me there' button.
//					Assumptions: Campaign Member ID is passed
//					as URL parameter
//                  
// Sep 11, 2015   : Divya Rao         Original
//***************************************************************************/

public class FFHR1_RedemptionController {
	String Location{get;set;}
	FFHR1_Campaign__c cmp{get;set;}
	public String RedeemCodeName{get;set;}
	public FFHR1_Redemption_Code__c ChosenRedemptionCode{get;set;}
	public FFHR1_RedemptionController() {
		// set redemption center url on campaign object
		cmp= new FFHR1_Campaign__c();
		List<FFHR1_Campaign__c> campaigns=new List<FFHR1_Campaign__c>();
		//Id cmpMemberId = ApexPages.currentPage().getParameters().get('memberId');
		List<FFHR1_Campaign_Member__c> campaignMembers=new List<FFHR1_Campaign_Member__c>();
		campaignMembers=getCampaignMember();//[SELECT Campaign__c,Id FROM FFHR1_Campaign_Member__c WHERE Id=:cmpMemberId];
		campaigns=[SELECT Redemption_Center__c FROM FFHR1_Campaign__c WHERE ID=:campaignMembers[0].campaign__c];
		Location=campaigns[0].Redemption_Center__c;
		system.debug('Location URL:::'+Location);
		setRedemptionCode();
		setRedeemCodeName();

	}
	//Helper Method to retrieve available redemption codes and select one to be displayed on page
	//Returns a FFHR1_Redemption_Code__c object
	public FFHR1_Redemption_Code__c setRedemptionCode()
	{
		List<FFHR1_Redemption_Code__c> lstRedemptionCodes=new List<FFHR1_Redemption_Code__c>();
		List<FFHR1_Redemption_Code__c> lstCMRedemptionCodes=new List<FFHR1_Redemption_Code__c>();
		FFHR1_Redemption_Code__c redeemCode=new FFHR1_Redemption_Code__c();
		try
		{
			if(ApexPages.currentPage().getParameters().get('memberId') != null) {
            	String cmpMemberId = ApexPages.currentPage().getParameters().get('memberId');
            	lstCMRedemptionCodes=[SELECT Id,Name,Redeemed__c,Campaign_Member__c FROM FFHR1_Redemption_Code__c WHERE Campaign_Member__c=:cmpMemberId];
            	if(lstCMRedemptionCodes.size()>0)
            	{
            		List<FFHR1_Campaign_Member__c> listCM=new list<FFHR1_Campaign_Member__c>();
            		listCM=getCampaignMember();

            		if(lstCMRedemptionCodes[0].Redeemed__c==false&&listCM[0].Status__c!='Rewarded')
            		{
            			redeemCode=lstCMRedemptionCodes[0];
            			ChosenRedemptionCode=redeemCode;
            			System.debug('Chosen Redemption Code for existing:::::++++'+ChosenRedemptionCode);
            			return ChosenRedemptionCode;
            		}
            		else
            		{
            			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Sorry! You have already redeemed your reward.'));
            			return null;
            		}
            		
            	}
            	else
            	{
            		lstRedemptionCodes=[SELECT Id,Name,Redeemed__c,Campaign_Member__c FROM FFHR1_Redemption_Code__c WHERE redeemed__c=false AND Campaign_Member__c=null];
            		System.debug('Number of available Redemption codes:::::'+lstRedemptionCodes.size());
            		redeemCode=lstRedemptionCodes[0];
            		ChosenRedemptionCode=redeemCode;
            	}
            	
            }
            else{
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'The system is unable to process the request. Please contact the system administrator.No Campaign Member in Parameter'));
            }
        }
        catch(Exception ex)
        {
        	return null;
        }
        return ChosenRedemptionCode;
	}
	
	// Method to set the Take me there location to city mapper URL
	// On click of the button, user is redirected to City Mapper URL
	// along with that, redeemed__c field of redemption code is set to true
	// Campaign Member status set to 'Rewarded'
	public PageReference getLocation()
	{
		List<FFHR1_Redemption_Code__c> lstRedeemCodes=new List<FFHR1_Redemption_Code__c>();
		List<FFHR1_Campaign_Member__c> listCM=new List<FFHR1_Campaign_Member__c>();
		FFHR1_Campaign_Member__c currentCM=new FFHR1_Campaign_Member__c();
		listCM=getCampaignMember();
		if(listCM.size()>0)
		{
			currentCM=[SELECT Status__c,Id FROM FFHR1_Campaign_Member__c WHERE Id=:listCM[0].id];
			if(currentCM.Status__c=='Rewarded')
			{
				return null;
			}
			else
			{
				currentCM.Status__c='Rewarded';
				update currentCM;
			}
			
		}

		//ChosenRedemptionCode.Redeemed__c=true;
		if(ChosenRedemptionCode!=null)
		{
			System.debug('We got here++++++ Not null code'+ChosenRedemptionCode);
			lstRedeemCodes=[SELECT id,Name,Redeemed__c FROM FFHR1_Redemption_Code__c WHERE ID=:ChosenRedemptionCode.Id];
			if(lstRedeemCodes.size()>0)
			{
				lstRedeemCodes[0].Redeemed__c=true;
				update lstRedeemCodes[0];
			}
			return new PageReference(Location);
		}
		else
		{
			return null;
		}
	}
	
	public String setRedeemCodeName()
	{
		String redemptionCode;
		if(ChosenRedemptionCode!=null)
		{
          redemptionCode=ChosenRedemptionCode.Name;
          RedeemCodeName=redemptionCode;
	    }
	    else
	    {
	    	RedeemCodeName='Code Redeemed';
	    }
	    return RedeemCodeName;
	}

	//Action method on page load to set the campaign member id on displayed redeem code.
	//Once this is updated, code can not be reused
	public PageReference updateRedeemCode()
	{
		List<FFHR1_Redemption_Code__c> lstRedemptionCodes=new List<FFHR1_Redemption_Code__c>();
		FFHR1_Redemption_Code__c redeemCode=new FFHR1_Redemption_Code__c();
        List<FFHR1_Campaign_Member__c> listCM = new List<FFHR1_Campaign_Member__c>();
        listCM=getCampaignMember();
        if(listCM.size()>0)
        {
			//redeemCode.Campaign_Member__c=listCM[0].id;
			system.debug('Redeem Code cm::::'+redeemCode.Campaign_Member__c);
			if(ChosenRedemptionCode!=null){
				lstRedemptionCodes=[SELECT Id,Name,Redeemed__c,Campaign_Member__c FROM FFHR1_Redemption_Code__c WHERE Id=:ChosenRedemptionCode.id];
		    	if(lstRedemptionCodes.size()>0)
		    	{
		    		lstRedemptionCodes[0].Campaign_Member__c=listCM[0].id;
		    		update lstRedemptionCodes[0];
		    	}
		    }
		    else
		    {
		    	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'You have already received/redeemed your code.'));
		    	return null;
		    }
	    	System.debug('Redemption code After assigning code:::::: '+lstRedemptionCodes[0]);
	    	//update lstRedemptionCodes[0];
	    }
	    return null;
	}

	public List<FFHR1_Campaign_Member__c> getCampaignMember()
	{
		Id cmId = ApexPages.currentPage().getParameters().get('memberId');
        List<FFHR1_Campaign_Member__c> listCM = new List<FFHR1_Campaign_Member__c>([Select Id,Campaign__c,Status__c from FFHR1_Campaign_Member__c where Id =: cmId]);
        return listCM;
	}
}