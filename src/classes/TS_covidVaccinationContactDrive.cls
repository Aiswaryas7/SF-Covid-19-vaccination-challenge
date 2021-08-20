/**
 * Created by Aiswarya.S on 8/19/2021.
 */

public with sharing class TS_covidVaccinationContactDrive {

   @AuraEnabled(cacheable=true)
    public static List<People__c> getPeopleList() {
       
        List<People__c> plist = [SELECT Id, Name,Longitude__c,Latitude__c,Distance__c,Drive_Location__c,Age__c
                FROM People__c];
        return [SELECT  Name,Age__c,Drive_Location__c,Distance__c
                FROM People__c ORDER BY Age__c DESC ];
    }
}