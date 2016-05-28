global with sharing class sf1Expense_ChangeStatus {
    public sf1Expense_ChangeStatus(ApexPages.StandardController controller) { }

    @RemoteAction
    global static sf1Result submitData(sf1Data data) {
        try {
            String SOQL;
            Expense__c expense;
            String ExpenseID = data.ExpenseID;
            
            SOQL = '';
            SOQL += 'SELECT ID, Name, isReimbursable__c, isAmex2Concur__c, isMe2Concur__c ';
            SOQL += 'FROM Expense__c ';
            SOQL += 'WHERE id = :ExpenseID ';
            System.debug('SOQL: ' + SOQL);
            expense = Database.query(SOQL);

            expense.isReimbursable__c = data.isReimbursable;
            expense.isAmex2Concur__c = data.isAmex2Concur;
            expense.isMe2Concur__c = data.isMe2Concur;
            
            update expense;
        } catch (Exception ex) {
            return new sf1Result(ex);
        }
        return new sf1Result(data.ExpenseID); 
    }
    
    global class sf1Data {
        global String ExpenseId { get; set; }
        global Boolean isReimbursable { get; set; }
        global Boolean isAmex2Concur { get; set; }
        global Boolean isMe2Concur { get; set; }
    }
}