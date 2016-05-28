@isTest
public class sf1Expense_AddReceipt_Test{
    @isTest
        public static void testExtension() {
            Trip__c t = sf1TestUtil.makeTrip();
            Expense__c e = sf1TestUtil.makeExpense(t);
            ApexPages.StandardController c = new ApexPages.StandardController(e);
            new sf1Expense_AddReceipt(c);
        }

    @isTest
        public static void testAddReceipt() {
            Trip__c t = sf1TestUtil.makeTrip();
            insert t;
            Expense__c e = sf1TestUtil.makeExpense(t);
            insert e;
            
            sf1Expense_AddReceipt.sf1Data data = new sf1Expense_AddReceipt.sf1Data();
            data.sImage = sf1TestUtil.getImage();
            data.name = 'Test String';
            data.ParentId = e.id;
            
            sf1Expense_AddReceipt.submitData(data);
        }
}