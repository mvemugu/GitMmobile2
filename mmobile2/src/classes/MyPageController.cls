public with sharing class MyPageController extends PageControllerBase {

  public MyComponentController myComponent1Controller {set;
    get{
        //get the map, then the component controller using the appropriate key
        if(getComponentControllerMap()!=null){
          MyComponentController mcc;
          mcc = (MyComponentController )getComponentControllerMap().get('component1');
          if(mcc!= null)
             return mcc;
        }
        //just in case something goes wrong return something...this can be handled better
        return new MyComponentController(); 
    }
  }
  public MyComponentController myComponent2Controller {set;
    get{
        //get the map, then the component controller using the appropriate key
        if(getComponentControllerMap()!=null){
          MyComponentController mcc;
          mcc = (MyComponentController )getComponentControllerMap().get('component2');
          if(mcc!= null)
             return mcc;
        }
        //just in case something goes wrong return something...this can be handled better
        return new MyComponentController(); 
    }
  }
    
  
    
  public PageReference callComponent1ControllerMethod() {
    myComponent1Controller .incrementValue(); 
    return null;
  }
  public PageReference callComponent2ControllerMethod() {
    myComponent2Controller .incrementValue(); 
    return null;
  } 
  
  public MyPageController () {
    system.debug('I am in Page constructor Mallik');
  }
}