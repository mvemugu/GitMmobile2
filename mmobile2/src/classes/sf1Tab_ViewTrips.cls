public with sharing class sf1Tab_ViewTrips {
    public List<Trip__c> currentTrips {
        get {
            return FindTrips(false);
        }
    }

    public List<Trip__c> pastTrips {
        get {
            return FindTrips(true);
        }
    }

    private List<Trip__c> FindTrips(Boolean isSubmited) {
        String SOQL;

        SOQL = '';
        SOQL += 'SELECT Id,isActive__c,Local2Concur__c,Location__c,Name,StartDate__c,StopDate__c,SubmitedReport__c,Total_Expenses__c ';
        SOQL += 'FROM Trip__c ';
        SOQL += 'WHERE SubmitedReport__c = :isSubmited ';
        SOQL += 'ORDER BY StartDate__c DESC ';
        if (isSubmited) {
            SOQL += 'LIMIT 10 ';
        }
        return Database.query(SOQL);
    }
}