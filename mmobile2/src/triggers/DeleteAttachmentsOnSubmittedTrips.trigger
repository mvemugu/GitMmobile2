trigger DeleteAttachmentsOnSubmittedTrips on Trip__c (after update) {
    if (trigger.isAfter && trigger.isUpdate) {
        Set<ID> tripIDs = new Set<ID>();
        for (Trip__c trip : trigger.new) {
            if ((trip.SubmitedReport__c) && (trip.SubmitedReport__c != trigger.oldMap.get(trip.id).SubmitedReport__c)) {
                tripIDs.add(trip.id);                
            }
        }
        DELETE [SELECT BodyLength,ContentType,CreatedDate,Id,IsPrivate,LastModifiedDate,Name,OwnerId,ParentId,Parent.Id,Parent.Name
                FROM Attachment
                WHERE ParentID in (SELECT ID From Expense__c WHERE Trip__c in :tripIDs)];

    }
}