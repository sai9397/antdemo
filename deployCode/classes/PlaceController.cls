public class PlaceController {
            
    public List<Places__c> listOfplaces { get; set; }
    public String country{ get; set;} 
    private ApexPages.StandardController tour1{get;set;}
    public Tour_Packages__c tour2{get;set;}
    public List<Places__c> listOfSearchplaces { get; set; }
    public List<Tour_Packages__c> tour{set;get;}
    public  Integer index=0;
    public  Integer size=3;
  	public  Integer count;
    public Boolean boolvalue {get;set;}   
    public Boolean afterSearch {get;set;}
    public string value { get; set;}
   
    public PlaceController(ApexPages.StandardController cont){ 
        tour1=cont;
        tour2=(Tour_Packages__c)cont.getRecord();
         System.debug(tour1.getId());
        listOfplaces = [select id, name, country__c, city__c, rating__c from places__c LIMIT : size    OFFSET  :index];
        tour = [Select id, Cost_per_Day__c,Tour_Package_Detail__c,Name,Country__c from Tour_Packages__c where Tour_Package_Detail__c != null];
        
    } 
    public List<places__c> getplaceController(){    
       
            listOfSearchplaces = [SELECT id, name, country__c, city__c, rating__c from places__c 
                   where country__c =: country ORDER BY rating__c Desc LIMIT : size    OFFSET  :index];
             tour = [Select id, Cost_per_Day__c,Tour_Package_Detail__c,Name,country__c from Tour_Packages__c
                     where country__c =: country and Tour_Package_Detail__c != null];
 
        return listOfSearchplaces;   
    }
    public pagereference contactpage(){
        if(country!=null){boolvalue = true; afterSearch=true;
        }else
        {    
        boolvalue = false;afterSearch=false;    
        }
        index=0;
         system.debug('boolvalue'+boolvalue);          
        return null;
    }
    public List<Places__c> getplacedetails(){   
        listOfplaces = new List<places__c>();
          listOfplaces=  [select id, name, country__c, city__c, rating__c from places__c  LIMIT : size    OFFSET  :index ];
         return listOfplaces;
    }   
    public pagereference BookPackage(){
         //value = apexpages.currentPage().getParameters().get('inpval');
        //tour2= [select Name from Tour_Packages__c where Name =:  tour2.name ];
       // Tour_Packages__c tt=new Tour_Packages__c(id=value);
        pagereference pr = new pagereference('/apex/newcustomer');
        System.debug(value);
         pr.setRedirect(true);
        pr.getParameters().put('name',tour2.Name);
         pr.setRedirect(false);
        return pr;
    } 
    public void firstmethod(){        
         index=0;
 
     }
      public void previousmethod(){      
          index=index-size;
                
    }
    public void nextmethod(){    
        index=size+index;
         
    }    
    public void lastmethod(){
        count=[select count() from places__c];
        index=count-size;     
        system.debug(index);
       // getplaceController(); 
    }   
    public boolean getPrev(){
         if(index==0)
             return TRUE;
         return FALSE;
    }   
    public boolean getNext(){
        if(country!=null){
        count=[select count() from places__c where country__c =: country];
            System.debug(count);
        }else{
        count=[select count() from places__c];
            System.debug(count);	
        }
        System.debug(count);
        if(index==count-size)
            return TRUE;
        return FALSE;        
    }
    

}