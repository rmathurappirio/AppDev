public virtual class TValueDocumentFieldsBase {

    class TVDocEvent {
        public String eventName {get; set;}
        public Date eventDate {get; set;}
        public Double amount {get; set;}
        public Double weightedUnknown {get; set;}
        public Integer eventNumber {get; set;}
        public Integer period {get; set;}
        public Date endDate {get; set;}
        public String memo {get; set;}
        public Integer specialSeriesType {get; set;}
        public Double rateChangeRate {get; set;}
    }


    class TVDocEventType {
        public Integer typeId {get; set;}
        public String name {get; set;}
        public Integer groupId {get; set;}
        public Integer eventBaseType {get; set;}
    }


    String lastUnknownValue = '-1';
    String rate = '-1';
    String label = '';
    String compounding = '';
    List <TVDocEvent> cfmEvents = new List<TVDocEvent>();
    List <TVDocEventType> curEventTypes = new List<TVDocEventType>();
    //List <TVDocAmortLine> amortLines = new List<TVDocAmortLine>();


    public TValueDocumentFieldsBase () {
    }

    
    public virtual Boolean saveFieldValues(TValueDocument__c tvDoc) {
        return true;
    }


    @TestVisible protected Decimal numberOfEvents() {  return cfmEvents.size(); }

    @TestVisible protected Double lastUnknownValue() { 
        Double amount; 
        if (lastUnknownValue == '1e+100') { amount = null; }
        else {amount = Double.valueOf(lastUnknownValue); }
        return amount; 
    }

    @TestVisible protected Double rate() {  
        Double amount; 
        if (rate == '1e+100') { amount = null; }
        else {amount = Double.valueOf(rate); }
        return amount; 
    }
    
   @TestVisible protected String label() {  return label; }
    
    @TestVisible protected String eventType(Integer rowNumber) {  
        String eventNameStr = '';
        if ((rowNumber > 0) && (rowNumber <= cfmEvents.size())) {
            TVDocEvent tvDocEvent = cfmEvents.get(rowNumber - 1);
            eventNameStr = tvDocEvent.eventName;
        }
        return eventNameStr; 
    }

   @TestVisible protected Date eventDate(Integer rowNumber) {  
        Date eventDate = null;
        if ((rowNumber > 0) && (rowNumber <= cfmEvents.size())) {
            TVDocEvent tvDocEvent = cfmEvents.get(rowNumber - 1);
            eventDate = tvDocEvent.eventDate;
        }
        return eventDate; 
    }

   @TestVisible protected Double eventAmount(Integer rowNumber) {  
        Double amount = null;
        if ((rowNumber > 0) && (rowNumber <= cfmEvents.size())) {
            TVDocEvent tvDocEvent = cfmEvents.get(rowNumber - 1);
            amount = tvDocEvent.amount;
        }
        return amount; 
    }

   @TestVisible protected Integer eventNumber(Integer rowNumber) {  
        Integer eventNum = null;
        if ((rowNumber > 0) && (rowNumber <= cfmEvents.size())) {
            TVDocEvent tvDocEvent = cfmEvents.get(rowNumber - 1);
            eventNum = tvDocEvent.eventNumber;
        }
        return eventNum; 
    }

    @TestVisible protected String eventPeriod(Integer rowNumber) {  
        String eventPeriodStr = '';
        if ((rowNumber > 0) && (rowNumber <= cfmEvents.size())) {
            TVDocEvent tvDocEvent = cfmEvents.get(rowNumber - 1);
            eventPeriodStr = getEventPeriod(tvDocEvent.period);
        }
        return eventPeriodStr; 
    }

     @TestVisible protected Date eventEndDate(Integer rowNumber) {  
        Date eventDate = null;
        if ((rowNumber > 0) && (rowNumber <= cfmEvents.size())) {
            TVDocEvent tvDocEvent = cfmEvents.get(rowNumber - 1);
            eventDate = tvDocEvent.endDate;
        }
        return eventDate; 
    }

    @TestVisible protected String eventMemo(Integer rowNumber) {  
        String memoStr = '';
        if ((rowNumber > 0) && (rowNumber <= cfmEvents.size())) {
            TVDocEvent tvDocEvent = cfmEvents.get(rowNumber - 1);
            memoStr = tvDocEvent.memo;
        }
        return memoStr; 
    }

    @TestVisible protected Double eventRateChangeRate(Integer rowNumber) {  
        Double rate = null;
        if ((rowNumber > 0) && (rowNumber <= cfmEvents.size())) {
            TVDocEvent tvDocEvent = cfmEvents.get(rowNumber - 1);
            if (tvDocEvent.eventName == 'Rate Change') { rate = tvDocEvent.rateChangeRate; }
        }
        return rate; 
    }

    @TestVisible protected String eventRateChangeCompounding(Integer rowNumber) {  
        String eventPeriodStr = '';
        if ((rowNumber > 0) && (rowNumber <= cfmEvents.size())) {
            TVDocEvent tvDocEvent = cfmEvents.get(rowNumber - 1);
            if (tvDocEvent.eventName == 'Rate Change') { 
                eventPeriodStr = getEventPeriod(tvDocEvent.period);
            }
        }
        return eventPeriodStr; 
    }


    public void parseTVDoc(String tvDocJson) {
        String tempStr;
        Integer tempInt;
        JSONParser parser = JSON.createParser(tvDocJson); 
        while (parser.nextToken() != null) { 
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){ 
                String fieldName = parser.getText(); 
                parser.nextToken(); 
                if(fieldName == 'lastUnknownValue'){ 
                    lastUnknownValue = parser.getText(); 
                } 
                else if(fieldName == 'rate'){ 
                    rate = parser.getText(); 
                } 
                else if(fieldName == 'label'){ 
                    label = parser.getText(); 
                } 
                else if(fieldName == 'compounding'){ 
                    compounding = parser.getText(); 
                } 
                else if(fieldName == 'events'){
                    if(parser.getCurrentToken() == JSONToken.START_ARRAY){
                        while(parser.nextToken() != null){
                            if(parser.getCurrentToken() == JSONToken.START_OBJECT){
                                //TVDocEvent tvDocEvent = (TVDocEvent) parser.readValueAs(TVDocEvent.class); 
                                TVDocEvent tvDocEvent = new TVDocEvent();

                                while(parser.nextToken() != null){
                                    if(parser.getCurrentToken() == JSONToken.FIELD_NAME){
                                        String fieldName2 = parser.getText(); 
                                        parser.nextToken(); 
                                        if(fieldName2 == 'eventName'){
                                            tvDocEvent.eventName = parser.getText();
                                        }
                                        else if(fieldName2 == 'eventDate'){
                                            tempStr = parser.getText();
                                            if (tempStr != null) {
                                                tempInt = tempStr.indexOf('T');
                                                if (tempInt != -1) {
                                                    tempStr = tempStr.substring(0, tempStr.indexOf('T'));
                                                    tvDocEvent.eventDate = Date.valueOf(tempStr);
                                                }
                                            }
                                        }
                                        else if(fieldName2 == 'amount'){
                                            tempStr = parser.getText();
                                            if (tempStr == '1e+100') { tvDocEvent.amount = null;}
                                            else {tvDocEvent.amount = Double.valueOf(tempStr); }
                                        }
                                        else if(fieldName2 == 'weightedUnknown'){
                                            tempStr = parser.getText();
                                            if (tempStr == '1e+100') { tvDocEvent.weightedUnknown = null;}
                                            else {tvDocEvent.weightedUnknown = Double.valueOf(tempStr); }
                                        }
                                        else if(fieldName2 == 'number'){
                                            tempStr = parser.getText();
                                            if (tempStr == '1000000') { tvDocEvent.eventNumber = null;}
                                            else {tvDocEvent.eventNumber = Integer.valueOf(tempStr); }
                                        }
                                        else if(fieldName2 == 'period'){
                                           tvDocEvent.period = parser.getIntegerValue();
                                        }
                                        else if(fieldName2 == 'endDate'){
                                            tempStr = parser.getText();
                                            if (tempStr != null) {
                                                tempInt = tempStr.indexOf('T');
                                                if (tempInt != -1) {
                                                    tempStr = tempStr.substring(0, tempStr.indexOf('T'));
                                                    tvDocEvent.endDate = Date.valueOf(tempStr);
                                                }
                                            }
                                        }
                                        else if(fieldName2 == 'memo'){
                                            tvDocEvent.memo = parser.getText();
                                        }
                                        else if(fieldName2 == 'specialSeriesType'){
                                            tvDocEvent.specialSeriesType = parser.getIntegerValue();
                                        }
                                        else if(fieldName2 == 'rateChangeRate'){
                                            tempStr = parser.getText();
                                            if (tempStr == '1e+100') { tvDocEvent.rateChangeRate = null;}
                                            else {tvDocEvent.rateChangeRate = Double.valueOf(tempStr); }
                                        }
                                    }
                                    else if (parser.getCurrentToken() == JSONToken.END_OBJECT){
                                        break;
                                    }
                                }
                                cfmEvents.add(tvDocEvent); 
                            }
                            else if(parser.getCurrentToken() == JSONToken.END_ARRAY){
                                break;  
                            }
                        }
                    }
                }
                else if(fieldName == 'curEventTypes'){
                    if(parser.getCurrentToken() == JSONToken.START_ARRAY){
                        while(parser.nextToken() != null){
                            if(parser.getCurrentToken() == JSONToken.START_OBJECT){
                                TVDocEventType tvDocEventType = new TVDocEventType();

                                while(parser.nextToken() != null){
                                    if(parser.getCurrentToken() == JSONToken.FIELD_NAME){
                                        String fieldName2 = parser.getText(); 
                                        parser.nextToken(); 
                                        if(fieldName2 == 'typeId'){
                                            tvDocEventType.typeId = parser.getIntegerValue();
                                        }
                                        else if(fieldName2 == 'name'){
                                            tvDocEventType.name = parser.getText();
                                        }
                                        else if(fieldName2 == 'groupId'){
                                            tvDocEventType.groupId = parser.getIntegerValue();
                                        }
                                        else if(fieldName2 == 'eventBaseType'){
                                            tvDocEventType.eventBaseType = parser.getIntegerValue();
                                        }
                                    }
                                    else if (parser.getCurrentToken() == JSONToken.END_OBJECT){
                                        break;
                                    }
                                }
                                curEventTypes.add(tvDocEventType); 
                            }
                            else if(parser.getCurrentToken() == JSONToken.END_ARRAY){
                                break;  
                            }
                        }
                    }
                }
                //else if(fieldName == 'someObject'){   
                //  if(parser.getCurrentToken() == JSONToken.START_OBJECT){
                //      while(parser.nextToken() != null){
                //          if(parser.getCurrentToken() == JSONToken.FIELD_NAME){
                //              if(parser.getText() == 'dateTime'){
                //                  parser.nextToken();
                //                  this.start.gDateTime = parser.getDateTimeValue();
                //                  break;  
                //              }
                //          }
                //      }
                //  }                   
                //}
            }
        }       
    }


   @TestVisible private String getEventTypeString_NOT_USED(Integer typeId) {
        String str = 'test';
        Boolean done = false;
        for (Integer i = 0; (! done) && (i < curEventTypes.size()); i++) {
            TVDocEventType tvDocEventType = curEventTypes.get(i);
            if (tvDocEventType.typeId == typeId) {
                done = true;
                str = tvDocEventType.name;
            }
        }

        return str;
    }


    @TestVisible private String getEventPeriod(Integer period) {
        String str = '';
        if (period == 7) { str = 'Monthly'; }
        else if (period == 9) { str = 'Quarterly'; }
        else if (period == 12) { str = 'Semiannual'; }
        else if (period == 13) { str = 'Annual'; }
        else if (period == 2) { str = 'Exact Days'; }
        else if (period == 3) { str = 'Daily'; }
        else if (period == 4) { str = 'Weekly'; }
        else if (period == 5) { str = 'Bi-weekly'; }
        else if (period == 6) { str = 'Half-month'; }
        else if (period == 8) { str = '2-Month'; }
        else if (period == 10) { str = '4-Month'; }
        else if (period == 11) { str = '4-Week'; }
        else if (period == 1) { str = 'Continuous'; }
        else if (period == 0) { str = 'None'; }

        return str;
    }
    

    public TValueDocument__c selectAllQuery(ID tvId) {
        TValueDocument__c tvObj = null;
        String objectName = 'TValueDocument__c';  
        String query = 'SELECT ';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
 
        // Grab the fields from the describe method and append them to the queryString one by one.
        Boolean addComma = false;
        for(String s : objectFields.keySet()) {
           if (addComma) { query += ', ' + s; }
           else { query += s; addComma = true; }
        }
 
        // Add FROM statement
        query += ' FROM ' + objectName;
 
        // Add on a WHERE/ORDER/LIMIT statement.
        query += ' WHERE id = \'' + tvId + '\''; 
  
        //QueryResult qResult  = database.query(query);
        //tvObj = (TValueDocument__c) qResult.records[0];
        tvObj = (TValueDocument__c) database.query(query);
        return tvObj;
    }
    


}