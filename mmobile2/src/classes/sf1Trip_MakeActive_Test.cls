@isTest
public class sf1Trip_MakeActive_Test{
    @isTest
        public static void testExtension() {
            Trip__c t = sf1TestUtil.makeTrip();
            ApexPages.StandardController c = new ApexPages.StandardController(t);
            new sf1Trip_MakeActive(c);
        }
    
    @isTest
        public static void testMakeActive() {
            Trip__c t = sf1TestUtil.makeTrip();
            insert t;
            
            sf1Trip_MakeActive.sf1Data data = new sf1Trip_MakeActive.sf1Data();
            data.TripId = t.id;
            
            sf1Trip_MakeActive.submitData(data);
        }
}