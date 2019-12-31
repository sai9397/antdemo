public class Booking {
    
  private ApexPages.StandardController booking;
    public id pdfbookid{set; get;}
     public string reportId{set; get;}
   public Booking__c book{Set;get;}
    public contact con{get;set;}
    public Schedule__c sch{get;set;}
    
  public Booking(ApexPages.StandardController controllerParam){
      booking = controllerParam;
		book= new Booking__C();
        book= [select name, customer__c,Schedule__c from booking__C where name =:  booking.getId() ];
             con= [select Id,name,firstname,lastname,email,birthdate,accountid,mobilephone  from contact where id =: book.Customer__c];
      sch= [select Total_cost__c,No_of_days__c,No_of_nights__c from Schedule__C where id =: book.Schedule__c ];
       System.debug(booking.getId());
       System.debug(book);
       System.debug(con.Email);
  }
   
}