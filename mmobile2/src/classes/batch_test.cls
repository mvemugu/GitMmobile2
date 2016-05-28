global class batch_test implements Database.Batchable<sObject>, Database.Stateful {
    static Integer value = 1;
    private String query = 'Select Id FROM Account limit 10';
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        value = 2;
       return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        // this will print 2 the first execution, and so on...
        System.debug('In Execute' + value++);
    }

    global void finish(Database.BatchableContext BC) {
        // this will print 2 + however many batches were executed
        System.debug('In finish' + value++);
   }
}