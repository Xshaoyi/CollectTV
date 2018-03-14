public without sharing class TNETFAQContentCtrl {

    @AuraEnabled
    public static List<TNET_FAQ__c> getFAQs(String labelStr){
            List<TNET_FAQ__c> faqList = [SELECT TNET_FAQ_Title__c,TNET_FAQ_Number__c,TNET_FAQ_Solution__c FROM TNET_FAQ__c WHERE TNET_FAQ_Type__c=:labelStr ORDER BY TNET_FAQ_Number__c ASC];
            return faqList;
        }
    
}