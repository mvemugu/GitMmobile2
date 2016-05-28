public class OpportunityHandler {
    
    
      public void SetOwnerOnBeforeUpdate(List < Opportunity > opptList, Map < Id, Opportunity > mapOldOpty) {
        for (Opportunity opp: opptList) {
            if (opp.Opportunity_Owner__c == null) 
                opp.Opportunity_Owner__c = opp.ownerId;
            else if (opp.Opportunity_Owner__c != null && opp.Opportunity_Owner__c != mapOldOpty.get(opp.id).Opportunity_Owner__c) 
                opp.ownerId = opp.Opportunity_Owner__c;
            else if (opp.ownerId != opp.Opportunity_Owner__c && opp.ownerId != mapOldOpty.get(opp.id).Opportunity_Owner__c) { 
                opp.Opportunity_Owner__c = opp.ownerId;
                system.debug('**Data Loader*********');
            }
        }
    }
    
     @future
    public static void activitiesOwnerUpdate(Set < Id > OptyIds,Map<Id, Id> ownerIdsMap) {
        List < Task > tskList = new List < Task > ();
        List < Event > evtList = new List < Event > ();
        //Map < Id, Id > eventRecUpdatesMap = new Map < Id, Id > ();
        
    //    DMLUtility dmlUtil = new DMLUtility();   
        /*All recurring Events are queried here*/
       try {
           
            for (Event evt: [SELECT Id, OwnerId,WhatId,IsRecurrence FROM Event WHERE WhatId != Null AND WhatId IN:OptyIds 
                           and (IsRecurrence = true or(IsRecurrence = false and RecurrenceActivityId  = ''))
                             and ownerId IN: ownerIdsMap.keySet()
                           limit 10000]) {
                    evt.OwnerId = ownerIdsMap.get(evt.OwnerId) ; 
               		System.debug('Events in loop=' + evt);
                    evtList.add(evt);
                  //  if (Limits.getDMLStatements() < Limits.getLimitDMLStatements()) {
                  //      update tsk;
                  //  }
                }
            if (evtList.size() > 0) { // if List has values    
                	System.debug('Events=' + evtList);
                   update evtList;
                    // Database.update(tskList);
                }
           for (Task tsk: [SELECT Id, OwnerId,WhatId,IsRecurrence FROM Task WHERE WhatId != Null AND WhatId IN:OptyIds 
                           and (IsRecurrence = true or(IsRecurrence = false and RecurrenceActivityId  = ''))
                           and ownerId IN: ownerIdsMap.keySet()
                           limit 10000]) {
                    tsk.OwnerId = ownerIdsMap.get(tsk.OwnerId) ; 
               		System.debug('Tasks in loop=' + tsk);
                    tskList.add(tsk);
                  //  if (Limits.getDMLStatements() < Limits.getLimitDMLStatements()) {
                  //      update tsk;
                  //  }
                }
            if (tskList.size() > 0) { // if List has values    
                	System.debug('Tasks=' + tskList);
                   update tskList;
                    // Database.update(tskList);
                }
        } catch (Exception e) {
            System.debug('Exeception' + e);
        }
}

}