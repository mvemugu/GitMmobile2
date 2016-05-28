@isTest
public class sf1Expense_ChangeStatus_Test{
    @isTest
        public static void testExtension() {
            Trip__c t = sf1TestUtil.makeTrip();
            Expense__c e = sf1TestUtil.makeExpense(t);
            ApexPages.StandardController c = new ApexPages.StandardController(e);
            new sf1Expense_ChangeStatus(c);
        }
    
    @isTest
        public static void testChangeStatus() {
            Trip__c t = sf1TestUtil.makeTrip();
            insert t;
            Expense__c e = sf1TestUtil.makeExpense(t);
            insert e;
            
            sf1Expense_ChangeStatus.sf1Data data = new sf1Expense_ChangeStatus.sf1Data();
            data.ExpenseId = e.id;
            data.isReimbursable = true;
            data.isAmex2Concur = true;
            data.isMe2Concur = true;
            
            sf1Expense_ChangeStatus.submitData(data);
        }
}