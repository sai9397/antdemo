public class emailexample {
  
	public static void sendMail(List<contact> cc){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        for(contact c:cc ){
         
            system.debug('bye'+c.Email);
            
        string[] to = new string[] {c.Email};   
        email.setToAddresses(to);     
        email.setSubject('Package cancellation');        
        email.setHtmlBody('Hello, <br/><br/>This is to inform you that the selected package is cancelled<br/><br/>Regards<br/> Developer');
        try{
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        }catch(exception e){
            apexpages.addmessage(new apexpages.message(apexpages.severity.error,e.getMessage()));
        }
        }
        
 
        
    }
}