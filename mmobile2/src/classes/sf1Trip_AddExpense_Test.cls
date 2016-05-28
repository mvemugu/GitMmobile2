@isTest
public class sf1Trip_AddExpense_Test{
    @isTest
        public static void testExtension() {
            returnInstance();
        }
    
    @isTest
        public static void testProperties() {
            sf1Trip_AddExpense addExp = returnInstance();
            
            // Piclist values obtained via Schema Describe.
            System.debug(addExp.Currencies);
            System.debug(addExp.PaymentTypes);
            
            // Lookups
            ExpenseType__c et = sf1TestUtil.makeExpenseType();
            insert et;
            System.debug(addExp.ExpenseTypes);
        }
    
    @isTest
        public static void testAddExpense() {
            Trip__c t = sf1TestUtil.makeTrip();
            insert t;
            Expense__c e = sf1TestUtil.makeExpense(t);
            
            sf1Trip_AddExpense.sf1Data data = new sf1Trip_AddExpense.sf1Data();
            data.expense = e;
            data.strIsReimbursable = 'true';
            data.strPurchaseDateTimeGTM = '2013-10-28T00:34:42.251Z';
            data.image = new sf1Expense_AddReceipt.sf1Data();
            data.image.sImage = sf1TestUtil.getImage();
            data.image.name = 'Test String';
            
            sf1Trip_AddExpense.submitData(data);
        }
    
    private static sf1Trip_AddExpense returnInstance() {
        Trip__c t = sf1TestUtil.makeTrip();
        Expense__c e = sf1TestUtil.makeExpense(t);
        ApexPages.StandardController c = new ApexPages.StandardController(e);
        return new sf1Trip_AddExpense(c);
    }
}