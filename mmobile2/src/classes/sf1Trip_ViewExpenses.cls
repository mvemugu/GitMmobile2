global with sharing class sf1Trip_ViewExpenses {
    private String TripID;
    private transient List<ExpenseData> transientExpenses;
    private transient List<SelectOption> transientYesNo;
    
    public Boolean soIsReimbursable { get; set; }
    public Boolean soIsUnreported { get; set; }
    public Decimal LocalAmount { get; set; }
    
    public List<SelectOption> soYesNo {
        get {
            if (transientYesNo == null) {
                transientYesNo = new List<SelectOption>();
                transientYesNo.add(new SelectOption('false', 'false'));
                transientYesNo.add(new SelectOption('true', 'true'));
            }
            return transientYesNo;   
        }
    }
    public List<ExpenseData> expenses {
        get {
            if (transientExpenses == null) {
                transientExpenses = findExpenses();
            }
            return transientExpenses;    
        }
    }
    
    public sf1Trip_ViewExpenses(ApexPages.StandardController controller) {
        TripID = controller.getId();
        soIsReimbursable = false;
        soIsUnreported = false;
    }
    
    public PageReference ApplyFilter() {
        transientExpenses = findExpenses();
        LocalAmount = null;
        return null;
    }

    private List<ExpenseData> findExpenses() {
        String SOQL;
        List<ExpenseData> output = new List<ExpenseData>();
        
        // SELECT AmountConcur_Formula__c,AmountConcur_Workflow__c,AmountLocal__c,Currency__c,Description__c,ExpenseOrder__c,ExpenseType__c,GPS__Latitude__s,GPS__Longitude__s,Id,isActiveTrip__c,isAmex2Concur__c,isMe2Concur__c,isMealExpense__c,isReimbursable__c,Location__c,Name,PaymentType__c,PurchaseDate__c,Report_Order__c,Trip__c FROM Expense__c WHERE Trip__c = 'a00G000000Mx5Ue' ORDER BY Report_Order__c ASC NULLS FIRST
        SOQL = '';
        SOQL += 'SELECT ID, Name, ';
        // Basic Data
        SOQL += 'Currency__c, PaymentType__c, AmountLocal__c, ExpenseType__c, PurchaseDate__c, Description__c, ';
        // Releated Trip data
        SOQL += 'Trip__c, Trip__r.Location__c, ExpenseType__r.Name, ';
        // Calculated Data
        SOQL += 'AmountConcur_Workflow__c, isActiveTrip__c, isMealExpense__c, ExpenseOrder__c, Report_Order__c, ';
        // Checkboxes
        SOQL += 'isReimbursable__c, isAmex2Concur__c, isMe2Concur__c, ';
        // Location
        SOQL += 'Location__c, GPS__Latitude__s, GPS__Longitude__s ';
        SOQL += 'FROM Expense__c ';
        SOQL += 'WHERE Trip__c = :TripID ';
        if (soIsReimbursable) {
            SOQL += 'AND isReimbursable__c = true ';
        }
        if (soIsUnreported) {
            SOQL += 'AND isMe2Concur__c = false ';
        }
        System.debug('LocalAmount: ' + LocalAmount);
        if (LocalAmount != null) {
            SOQL += 'AND AmountLocal__c = :LocalAmount ';
        }
        SOQL += 'ORDER BY Report_Order__c DESC';
        System.debug('SOQL: ' + SOQL);
        for (Expense__c expense : Database.query(SOQL)) {
            output.add(new ExpenseData(expense));
        }
        return output;
    }
    
    public class ExpenseData {
        public Expense__c record { get; private set; } 
        public Boolean hasNotes { get { return record.Description__c != null; } }
        public Boolean isLocalAmount { get { return record.Currency__c == 'Local'; } }
        public Boolean hasCoordenates { get { return (record.GPS__Latitude__s != null) && (record.GPS__Longitude__s != null); } }
        public String mapURL { get { return 'https://maps.google.com/?z=5&q=' + record.GPS__Latitude__s + ',' + record.GPS__Longitude__s; } }
        
        private ExpenseData() {}
        public ExpenseData(Expense__c record) {
            this.record = record;
        } 
    }
}