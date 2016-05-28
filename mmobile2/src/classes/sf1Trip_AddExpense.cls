global with sharing class sf1Trip_AddExpense {
    public sf1Trip_AddExpense(ApexPages.StandardController controller) { }

    public List<SelectOption> ExpenseTypes {
        get {
            if (ExpenseTypes == null) {
                ExpenseTypes = new List<SelectOption>();
                ExpenseTypes.add(new SelectOption('', '-- None --'));
                for (ExpenseType__c t : [SELECT Id,Name FROM ExpenseType__c ORDER BY Sorter__c DESC]) {
                    ExpenseTypes.add(new SelectOption(t.ID, t.Name));
                }
            }
            return ExpenseTypes;
        }
        private set;
    }

    public List<SelectOption> PaymentTypes {
        get {
            if (PaymentTypes == null) {
                PaymentTypes = new List<SelectOption>();
                PaymentTypes.add(new SelectOption('', '-- None --'));
                Schema.DescribeFieldResult dfr = Expense__c.PaymentType__c.getDescribe();
                for (Schema.PicklistEntry ple : dfr.getPicklistValues()) {
                    PaymentTypes.add(new SelectOption(ple.getValue(), ple.getLabel(), !ple.isActive()));
                }
            }
            return PaymentTypes;
        }
        private set;
    }
    
    public List<SelectOption> Currencies {
        get {
            if (Currencies == null) {
                Currencies = new List<SelectOption>();
                Currencies.add(new SelectOption('', '-- None --'));
                Schema.DescribeFieldResult dfr = Expense__c.Currency__c.getDescribe();
                for (Schema.PicklistEntry ple : dfr.getPicklistValues()) {
                    Currencies.add(new SelectOption(ple.getValue(), ple.getLabel(), !ple.isActive()));
                }
            }
            return Currencies;
        }
        private set;
    }
    
    @RemoteAction
    global static sf1Result submitData(sf1Data data) {
        ID recordID;
        
        try {
            System.debug('Data Received: ' + data.expense);
            
            // Add Expense
            data.procesSpecialValues();
            insert data.expense;
            data.addImage();
            recordID = data.expense.id;
            System.debug('Data Processed');
        } catch (Exception ex) {
            return new sf1Result(ex);
        }
        return new sf1Result(recordID); 
    }
    
    global class sf1Data {
        global Expense__c expense { get; set; }
        global sf1Expense_AddReceipt.sf1Data image { get; set; }

        // special values
        global String strIsReimbursable { get; set; }
        global String strPurchaseDateTimeGTM { get; set; }

        public void addImage() {
            image.ParentId = expense.id;
            sf1Result result = sf1Expense_AddReceipt.submitData(image);
            if (!result.isSuccess) {
                throw new sf1Exception(result.message);
            }
        }
                
        public void procesSpecialValues() {
            System.debug('Is Reimbursable: ' + strIsReimbursable);
            expense.isReimbursable__c = Boolean.valueOf(strIsReimbursable);
            System.debug('Date: ' + strPurchaseDateTimeGTM);
            expense.PurchaseDate__c = getDate(strPurchaseDateTimeGTM).Date();
        }
        
        private DateTime getDate(String value) {
            // iPhone Format Received "2013-10-28T00:34:42.251Z", "2013-10-28T00:34:42Z"
            // Format Required  �yyyy-MM-dd HH:mm:ss�

            String input = value;
            input = input.replace('T', ' ');
            input = input.substring(0, 19);
            System.debug('Date before processor: ' + value);
            System.debug('Date after processor: ' + input);
            return DateTime.valueOfGMT(input);
        }
    }
}