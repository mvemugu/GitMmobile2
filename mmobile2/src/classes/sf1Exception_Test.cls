@isTest
public class sf1Exception_Test{
    @isTest
        public static void testException() {
            sf1Expense_AddReceipt.submitData(null);
        }
    
    @isTest
        public static void testCodeCoverage() {
            sf1Exception ex = new sf1Exception(5);
        }
}