global class FFHR1_GenerateRedeemCodes {
	public FFHR1_GenerateRedeemCodes() {	
	}

	/* Webservice method to generate random redemption codes */
	webservice static void insertCodes(integer numOfCodes)
	{
		List<string> strCodes=new List<String>();
		List<FFHR1_Redemption_Code__c> lstRedemptionCodes=new List<FFHR1_Redemption_Code__c>();
		//Generate 200 codes
		for(Integer i=0;i<numOfCodes;i++)
		{
			String str=generateRandomString(7);

			FFHR1_Redemption_Code__c redeemCode=new FFHR1_Redemption_Code__c(Name=str);
			lstRedemptionCodes.add(redeemCode);

		}

		//system.assert(false,lstRedemptionCodes);
		system.debug('Redeem codes::::::'+lstRedemptionCodes);
		insert lstRedemptionCodes;		
		//return lstRedemptionCodes;
	}

    //Helper method for random string generation
    public static String generateRandomString(Integer len) {
    	final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
	    String randStr = '';
	    while (randStr.length() < len) {
	    Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
	    randStr += chars.substring(idx, idx+1);
    	}
    	return randStr; 
	}
}