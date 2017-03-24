public class TValueCloneController {
    TValueDocument__c newTValueObj;
    TValueDocument__c cloneTValueObj;
    String initReferer;
    
    public TValueCloneController() {
        newTValueObj = new TValueDocument__c();
        initReferer = ApexPages.currentPage().getHeaders().get('Referer');
        try {
            ID cloneId = ApexPages.currentPage().getParameters().get('id');
            cloneTValueObj = [select id, name, rate__c, Last_Unknown_Value__c, Opportunity__c, Date_1__c,
        							Event_Type_1__c, Amount_1__c, Number_1__c, Period_1__c, End_Date_1__c, Memo_1__c, data2__c,
        							eventType2__c, amount2__c,Number_2__c, period2__c, endDate2__c, memo2__c,
        							Date_3__c, Event_Type_3__c,Amount_3__c,Number_3__c,Period_3__c, End_Date_3__c, 
        							Memo_3__c, Date_4__c, Event_Type_4__c, Amount_4__c, Number_4__c, Period_4__c, 
        							End_Date_4__c, Memo_4__c from TValueDocument__c where id = :cloneId];
            
            newTValueObj.name = cloneTValueObj.name + '-copy';
            newTValueObj.rate__c = cloneTValueObj.rate__c;
            newTValueObj.Last_Unknown_Value__c = cloneTValueObj.Last_Unknown_Value__c;
            newTValueObj.Opportunity__c = cloneTValueObj.Opportunity__c;
            newTValueObj.Date_1__c = cloneTValueObj.Date_1__c;
        	newTValueObj.Event_Type_1__c = cloneTValueObj.Event_Type_1__c;
        	newTValueObj.Amount_1__c = cloneTValueObj.Amount_1__c;
        	newTValueObj.Number_1__c = cloneTValueObj.Number_1__c;
        	newTValueObj.Period_1__c = cloneTValueObj.Period_1__c;
        	newTValueObj.End_Date_1__c = cloneTValueObj.End_Date_1__c;
        	newTValueObj.Memo_1__c = cloneTValueObj.Memo_1__c;
        	newTValueObj.data2__c = cloneTValueObj.data2__c;
        	newTValueObj.eventType2__c = cloneTValueObj.eventType2__c;
        	newTValueObj.amount2__c = cloneTValueObj.amount2__c;
        	newTValueObj.Number_2__c = cloneTValueObj.Number_2__c;
        	newTValueObj.period2__c = cloneTValueObj.period2__c;
        	newTValueObj.endDate2__c = cloneTValueObj.endDate2__c;
        	newTValueObj.memo2__c = cloneTValueObj.memo2__c;
        	newTValueObj.Date_3__c = cloneTValueObj.Date_3__c;
        	newTValueObj.Event_Type_3__c = cloneTValueObj.Event_Type_3__c;
        	newTValueObj.Amount_3__c = cloneTValueObj.Amount_3__c;
        	newTValueObj.Number_3__c = cloneTValueObj.Number_3__c;
        	newTValueObj.Period_3__c = cloneTValueObj.Period_3__c;
        	newTValueObj.End_Date_3__c = cloneTValueObj.End_Date_3__c;
        	newTValueObj.Memo_3__c = cloneTValueObj.Memo_3__c;
        	newTValueObj.Date_4__c = cloneTValueObj.Date_4__c;
        	newTValueObj.Event_Type_4__c = cloneTValueObj.Event_Type_4__c;
        	newTValueObj.Amount_4__c = cloneTValueObj.Amount_4__c;
        	newTValueObj.Number_4__c = cloneTValueObj.Number_4__c;
        	newTValueObj.Period_4__c = cloneTValueObj.Period_4__c;
        	newTValueObj.End_Date_4__c = cloneTValueObj.End_Date_4__c;
        	newTValueObj.Memo_4__c = cloneTValueObj.Memo_4__c;
            
        }
        catch (Exception e) {
            cloneTValueObj = null;
        }
    }

    
    public PageReference save() {
        Attachment cloneAttachment = null;
        PageReference pageRef = new PageReference(initReferer);
        
        insert newTValueObj;
        
        // Copy the attachment to clone.
        if (cloneTValueObj != null) {
            // Get Attachment.
            try {
                cloneAttachment = [select id, parentId, name, body from Attachment where parentId = :cloneTValueObj.id];
            }
            catch (Exception e) {
                cloneAttachment = null;
            }
            if (cloneAttachment != null) {
                // Clone the attachment.
                Attachment attachObj = new Attachment(
                    ParentId = newTValueObj.id,
                    Name = cloneAttachment.name,
                    Body = cloneAttachment.body
                );
                insert attachObj;
            }
        }
        pageRef.getParameters().put('id', newTValueObj.id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    

    public PageReference cancel() {
        PageReference pageRef = new PageReference(initReferer);
        pageRef.setRedirect(true);
        return pageRef;
    }


    public String getInitialReferer() {
        return initReferer;
    }

    public String getName() {
        return 'TValueDocumentCloneController';
    }
    
    public TValueDocument__c getTValueDocument() {
        //if(tvalueObj == null) {
        //tvalueObj = [select id, name, rate__c, Opportunity__c from TValueDocument__c where id = :ApexPages.currentPage().getParameters().get('id')];
       //}
        return newTValueObj;
    }
}