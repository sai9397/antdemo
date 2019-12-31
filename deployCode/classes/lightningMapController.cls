public with sharing class lightningMapController {
    
    @AuraEnabled public static string country{get;set;} 
    @AuraEnabled
    public Static void setcountry(String mycountry) {
       
       country=mycountry;
         System.debug(''+country);
    }
    @AuraEnabled
    public Static String getCountry() {
        System.debug(country);
        return country;
    }
    @AuraEnabled
    public static list<accountLocationWrapper> getLocation(){
        list<accountLocationWrapper> lstALW = new list<accountLocationWrapper>();
        /*Query accounts records with billing address information */  
        List<places__c> mapplace;
        if(country==null || country==''){
            mapplace=[select id, name, country__c, city__c, rating__c,State__c from places__c 
                           Where country__c != null
                           And city__c != null 
                           limit 3];
            System.Debug('Empty'+mapplace);
        }
        else{ 
               mapplace=[ select id, name, country__c, city__c, rating__c,State__c from places__c 
                           Where country__c =: country
                           And city__c != null  
                           limit 3];
            System.Debug('Filled'+mapplace);
        }
            
        for(places__c acc :mapplace){
                               // first create "locationDetailWrapper" instance and set appropriate values
                               locationDetailWrapper oLocationWrap = new locationDetailWrapper();
                              // oLocationWrap.Street = acc.BillingStreet;
                              // oLocationWrap.PostalCode = acc.BillingPostalCode;
                               oLocationWrap.City = acc.city__c;
                               oLocationWrap.State = acc.State__c;
                               oLocationWrap.Country = acc.country__c;
                               
                               // create "accountLocationWrapper" instance, set values and add to final list. 
                               accountLocationWrapper oWrapper = new accountLocationWrapper();
                               oWrapper.icon = 'utility:location'; // https://www.lightningdesignsystem.com/icons/#utility
                               oWrapper.title = acc.Name;
                          //     oWrapper.description = acc.description;
                               oWrapper.location = oLocationWrap;
                               
                               lstALW.add(oWrapper);
                           }
        // retrun the "accountLocationWrapper" list
        return lstALW;
    }
    /* wrapper class to store required properties for "lightning:map" component' */ 
    public class accountLocationWrapper{
        @AuraEnabled public string icon{get;set;} 
        @AuraEnabled public string title{get;set;} 
        @AuraEnabled public string description{get;set;} 
        @AuraEnabled public locationDetailWrapper location{get;set;} 
    }
    /* sub wrapper class to store location details for "accountLocationWrapper" location property.*/ 
    public class locationDetailWrapper{
        @AuraEnabled public string Street{get;set;}
        @AuraEnabled public string PostalCode{get;set;}
        @AuraEnabled public string City{get;set;}
        @AuraEnabled public string State{get;set;}
        @AuraEnabled public string Country{get;set;}
    }
    
    
}