trigger Tour_cancell on Tour_Packages__c (after update) {
     public List<Contact> con  = new List<Contact>();
    for(Tour_Packages__c tp:Trigger.New){
        if(tp.active__c==false){
            for(contact c:[SELECT email from contact where contact.tour_package__c=:tp.id]){
                if(c.Email !=null){
                    con.add(c);
                }
                system.debug('hi'+c.email);     
            }
          
            emailexample.sendMail(con);
			          
        }
    }

}