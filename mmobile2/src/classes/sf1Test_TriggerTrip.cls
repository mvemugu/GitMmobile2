@isTest
public class sf1Test_TriggerTrip {
    @isTest
        public static void testTrigger() {
            Trip__c t = sf1TestUtil.makeTrip();
            insert t;
            
            t.SubmitedReport__c = true;
            update t;
        }
}