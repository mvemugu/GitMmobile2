public with sharing class MyComponentController extends ComponentControllerBase {
     private Integer myValue = 3;
    
  public Integer getIntValue() {
    return myValue; 
  }
    
  public void incrementValue() { 
    myValue++;
  }
  
   public MyComponentController() {
    system.debug('I am in component constructor Mallik');
  }
    
}