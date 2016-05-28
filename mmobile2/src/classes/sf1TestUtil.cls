@isTest
public class sf1TestUtil{
    public static Trip__c makeTrip() {
        Trip__c t = new Trip__c();
        t.StartDate__c = System.today();
        t.StopDate__c = System.today().addDays(7);
        t.Location__c = 'Test City';
        t.SubmitedReport__c = false;
        t.isActive__c = true;
        return t;
    }
    
    public static Expense__c makeExpense(Trip__c t) {
        Expense__c e = new Expense__c();
        e.Trip__c = t.id;
        e.AmountLocal__c = 0.01;
        e.PurchaseDate__c = t.StartDate__c;
        return e;
    }
    
    public static String getImage() {
        return 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQIW2PsWLH7PwAGlwLst8utJwAAAABJRU5ErkJggg==';
    }
    
    public static ExpenseType__c makeExpenseType() {
        ExpenseType__c et = new ExpenseType__c();
        et.isMeal__c = false;
        et.Name = 'Test';
        et.Sorter__c = 0;
        return et;
    }
}