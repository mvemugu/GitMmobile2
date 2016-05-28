@isTest
public class sf1Trip_ViewExpenses_Test{
	@isTest
        public static void testViewExpenses() {
            Trip__c t = sf1TestUtil.makeTrip();
            insert t;
            
            List<Expense__c> expenses = new List<Expense__c>();
            expenses.add(sf1TestUtil.makeExpense(t));
            expenses.add(sf1TestUtil.makeExpense(t));
            expenses.add(sf1TestUtil.makeExpense(t));
            insert expenses;
            
            ApexPages.StandardController c = new ApexPages.StandardController(t);
            sf1Trip_ViewExpenses ve = new sf1Trip_ViewExpenses(c);
        
            system.debug(ve.soYesNo);
            system.debug(ve.expenses);
            ve.ApplyFilter();
            
            ve.soIsReimbursable = true;
            ve.soIsUnreported = true;
            ve.LocalAmount = 0.01;
            ve.ApplyFilter();
        }
}