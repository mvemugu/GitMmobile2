public class canvasExtension {
    
     private final Account acct;
     public String jsonString {get; set;}
/* Write comments to commit to GIT*/
    public canvasExtension(ApexPages.StandardController controller) {   
        
        List<Account> account = [SELECT Id, Name FROM Account LIMIT 10]; 
        JSONGenerator generator = JSON.createGenerator(true);   //instantiation of the generator
        generator.writeStartObject();               // Writes the starting marker of a JSON object '{'
        generator.writeNumberField('count', account.size());           //Writes the # of contacts 
        generator.writeStringField('Name', account[0].name);
        generator.writeStringField('Name Id ', account[0].name);
        generator.writeEndObject();                 //Writes the ending marker of a JSON object '}'
        String jsonString = generator.getAsString();
        system.debug('Json String' + jsonString);
        

    }

}