trigger Opportunity on Opportunity (after delete, after insert, after update, before delete, before insert, before update) {
    OpportunityHandler optyIns = new OpportunityHandler();
     if (Trigger.isBefore) {
         for (Opportunity opp: Trigger.New) {
             opp.Bypass_VR__c = true;
         }
           
         
          IF(Trigger.isUpdate) {
            /* RG 4/21/2015 -R1.3 U1160 : SetOwnerOnBeforeUpdate method defination is in Opportunity Handler*/
            optyIns.SetOwnerOnBeforeUpdate(Trigger.New, Trigger.OldMap);            
        }
     }
    
    if (Trigger.isAfter) {

        if (Trigger.IsUpdate) {            
            //Update all activities owner for opportunity 
            Map<Id, Id> ownerIdsMap = new Map<Id, Id>();
            for(Opportunity oppty : Trigger.New) {
                ownerIdsMap.put(Trigger.OldMap.get(oppty.id).ownerId, Trigger.NewMap.get(oppty.id).ownerId);
            }
            system.debug('*****owner IDs Map : '+ownerIdsMap);
            OpportunityHandler.activitiesOwnerUpdate(Trigger.OldMap.keySet(), ownerIdsMap);
        }


    }

}