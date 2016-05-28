global with sharing class sf1Trip_MakeActive {
    public sf1Trip_MakeActive(ApexPages.StandardController controller) { }
    
    @RemoteAction
    global static sf1Result submitData(sf1Data data) {
        try {
            String TripID = data.TripID;
            
            String SOQL = '';
            SOQL += '';
            SOQL += 'SELECT ID, isActive__c ';
            SOQL += 'FROM Trip__c ';
            SOQL += 'WHERE isActive__c = TRUE OR id = :TripID ';
            
            List<Trip__c> trips = Database.query(SOQL);
            for (Trip__c trip : trips) {
                System.debug(trip);
                // If this is the current trip, then it should be active. Otherwise, deactivate it.
                Boolean isCurrent = (trip.id == TripID);
                trip.isActive__c = isCurrent;
            }
            update trips;
        } catch (Exception ex) {
            return new sf1Result(ex);
        }
        return new sf1Result(data.TripId); 
    }
    
    global class sf1Data {
        global String TripId { get; set; }
    }
}