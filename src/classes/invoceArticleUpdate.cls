public class invoceArticleUpdate {
    @InvocableMethod(label='Update Article' description='Update the last vied date field on article')
    public static void updateLastView() {
        DateTime dt = [select LastViewedDate from Test__ka limit 1].LastViewedDate;
        Id i = [select Id from KnowledgeArticle limit 1].Id;
        KbManagement.PublishingService.archiveOnlineArticle(i, null);

        /*
        system.debug('<<Date>>'+dt+' <<<ID>>>'+i);
        system.debug([select Id,Last_Viewed_On__c from Test__kav where PublishStatus='online' AND Language='en_US' AND KnowledgeArticleId =:i]);
        Test__kav t =[select Id,PublishStatus,Last_Viewed_On__c,KnowledgeArticleId from Test__kav where PublishStatus='online' AND Language='en_US' AND KnowledgeArticleId =:i];
        //t.PublishStatus = 'Archived';
        
        
        String articleId = 'Insert article ID';
		String id = KbManagement.PublishingService.editOnlineArticle (t.KnowledgeArticleId, true);
		system.debug(id);
        Test__kav t1 =[select Id,PublishStatus,Last_Viewed_On__c,KnowledgeArticleId from Test__kav where Id =:id];
		t1.Last_Viewed_On__c = dt;
        
        update t1;
        KbManagement.PublishingService.publishArticle(t.KnowledgeArticleId, false);
		KbManagement.PublishingService.restoreOldVersion (t.KnowledgeArticleId, 7);

		*/
		
    }
}