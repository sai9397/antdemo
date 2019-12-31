public class TourManage{
    
    public Schedule__c sd {set; get;}
    public Contact contact{set; get;}
    public Booking__c book{set;get;}    
    public Schedule__c schedule{set;get;}
	public String selectedRowIndex	{get;set;} 
    public Tour_Packages__c tpc{get;set;} 
    public Offer__c off{get;set;} 
	public Integer count = 0;
    public Decimal dis = 0;
    public Integer costcount=0;
    Public Decimal totalcost=0;
   	public Date datename {get; set;}
  
    public String strText {get;set;}
    public Tour_Packages__c tour1{set;get;}
    
	public TourManage(){
		 contact=new contact();
        schedule = new Schedule__c();
        tour1=new Tour_Packages__c();
        schedule.Total_Cost__c=0;
        book = new Booking__c();    
        strText = ApexPages.currentPage().getParameters().get('name');
        tour1=[select id,name,cost_per_day__c from Tour_Packages__c where name=: strText];
        contact.Tour_Package__c=tour1.Id;
        system.debug(strText);
    }
     
    public PageReference BookAnother(){
        
        PageReference pr = new PageReference('/apex/Googlemap');
        return pr;
        
    }
    
    public PageReference Save()	{
        
        
       try{
         upsert contact;       
        system.debug('savecontact');
        
        schedule.Tour_Package__c=tour1.Id;
        schedule.Customer__c=contact.Id;
        //tpc=[select Cost_per_day__c,id from Tour_Packages__c where id =: tour1.Name ];
        system.debug('beforeschedule');
         upsert schedule;
        system.debug('afterschedule');
        book.Customer__c= contact.id;
       	book.Schedule__c=schedule.id;
        book.Tour_Package__c=tour1.Id;
        book.Total_cost__c=schedule.Total_Cost__c; 
        upsert book;
           PageReference pr = new PageReference('/apex/BookingConfirmed');		
		return pr;
           }catch(Exception e){
            system.debug('schedulecatch');
            Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.FATAL, e.getMessage()));
               return null;
        }
       // System.debug(book.Customer__c+' '+contact.id);
        //System.debug(book.Schedule__c+''+schedule.id);
        //System.debug(book.Tour_Package__c+''+schedule.Tour_Package__c);
        //System.debug(book.Total_cost__c+''+schedule.Total_Cost__c);       
       
        //pr.setRedirect(True);
		
	}
    public void fetchCostDetails(){
        tpc = [SELECT id,Cost_per_Day__c FROM Tour_Packages__c WHERE Id =:  contact.Tour_Package__c];
        schedule.Total_Cost__c =schedule.Total_Cost__c+ tpc.Cost_per_Day__c*noOfWorkingdaysDiff;
        System.debug('hi');
      
       
         
    }
    public void OfferDetails(){
        if(contact.AccountId!=null){
        off=[select id, Discount__c from Offer__c where Account__c =: contact.AccountId];
        dis=off.Discount__c;
        costcount=0;
        system.debug('discount'+dis);
        schedule.Offer__c= off.Id;
        FinalCost();    
        }
        System.debug(off);           
    }
    public void FinalCost(){
        
        if(costcount==0){
        schedule.Total_Cost__c =  totalcost - (totalcost*dis)/100;
            costcount=1;
        }
            
            
        System.debug(off);           
    }
    public Integer noOfWorkingdaysDiff{set;get;}
    public void DayCaculate(){
        System.debug('daycalculate');
        noOfWorkingdaysDiff=schedule.From__c.daysBetween(schedule.To__c);
        if( noOfWorkingdaysDiff>0){
		schedule.No_of_Days__c= noOfWorkingdaysDiff;    
        schedule.No_of_Nights__c= noOfWorkingdaysDiff; 
        tpc = [SELECT id,Cost_per_Day__c FROM Tour_Packages__c WHERE name =:  tour1.Name];
        
        schedule.Total_Cost__c =tpc.Cost_per_Day__c*noOfWorkingdaysDiff;
        totalcost=Schedule.Total_cost__c;
        System.debug('hi'+totalcost);
        costcount=0;
        }
    }
        
    public PageReference viewplaces(){
    
    PageReference pr = new PageReference('/apex/googlemap');		
		return pr;
    }
    
}