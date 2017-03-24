public class TValueDocumentFields extends TValueDocumentFieldsBase {

    public override Boolean saveFieldValues(TValueDocument__c tvDoc) {
    
        tvDoc.numberOfRows__c = numberOfEvents();
        tvDoc.Last_Unknown_Value__c = lastUnknownValue();
        tvDoc.rate__c = rate();
        tvDoc.label__c = label();
        
        tvDoc.Date_1__c = eventDate(1);
        tvDoc.Event_Type_1__c = eventType(1);
        tvDoc.Amount_1__c = eventAmount(1);
        tvDoc.Number_1__c = eventNumber(1);
        tvDoc.Period_1__c = eventPeriod(1);
        tvDoc.End_Date_1__c = eventEndDate(1);
        tvDoc.Memo_1__c = eventMemo(1);
        
        tvDoc.data2__c = eventDate(2);
        tvDoc.eventType2__c = eventType(2);
        tvDoc.amount2__c = eventAmount(2);
        tvDoc.Number_2__c = eventNumber(2);
        tvDoc.period2__c = eventPeriod(2);
        tvDoc.endDate2__c = eventEndDate(2);
        tvDoc.memo2__c = eventMemo(2);
        
        tvDoc.Date_3__c = eventDate(3);
        tvDoc.Event_Type_3__c = eventType(3);
        tvDoc.Amount_3__c = eventAmount(3);
        tvDoc.Number_3__c = eventNumber(3);
        tvDoc.Period_3__c = eventPeriod(3);
        tvDoc.End_Date_3__c = eventEndDate(3);
        tvDoc.Memo_3__c = eventMemo(3);
        
        tvDoc.Date_4__c = eventDate(4);
        tvDoc.Event_Type_4__c = eventType(4);
        tvDoc.Amount_4__c = eventAmount(4);
        tvDoc.Number_4__c = eventNumber(4);
        tvDoc.Period_4__c = eventPeriod(4);
        tvDoc.End_Date_4__c = eventEndDate(4);
        tvDoc.Memo_4__c = eventMemo(4);
        
        tvDoc.Date_5__c = eventDate(5);
        tvDoc.Event_Type_5__c = eventType(5);
        tvDoc.Amount_5__c = eventAmount(5);
        tvDoc.Number_5__c = eventNumber(5);
        tvDoc.Period_5__c = eventPeriod(5);
        tvDoc.End_Date_5__c = eventEndDate(5);
        tvDoc.Memo_5__c = eventMemo(5);
        
    
        return true;
    }
}