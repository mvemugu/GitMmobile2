@RestResource(urlMapping='/Account/*')
global with sharing class AccountRestService{

    @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        delete account;
    }
    
    // Commit with changes 14

    @HttpGet
    global static Account doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
        return result;
    }
  
  @HttpPost
    global static String doPost(String name,
        String phone) {
        system.debug('In Post Mallikkkkkkkk');
        Account account = new Account();
        account.Name = name;
        account.phone = phone;        
        insert account;
        return account.Id;
    }
}
