/**
 * Created by yshao009 on 6/27/17.
 */

public without sharing class TNETAcknowledgementCtrl {
    @AuraEnabled
    public static String acknowledge(String activityName){
        String rs = '';
        try {
            User u = [SELECT ID,ContactId FROM User WHERE ID =: UserInfo.getUserId()];
            if(!String.isEmpty(u.ContactId)){
                TNET_Activity__c t = new TNET_Activity__c();
                t.Name = activityName;
                t.contact__c = u.ContactId;
                insert t;
                rs =  'Submitted on '+System.now().format('MM/dd/YYYY');
            }else{
                rs =  'Not Community User';
            }
        }catch(Exception e){
            rs = e.getMessage()+'\n'+e.getStackTraceString();
        }

        return rs;
    }

    @AuraEnabled
    public static String getInitData(String activityName){
        String rs = '';
        try {
            User u = [SELECT ID,ContactId FROM User WHERE ID =: UserInfo.getUserId()];
            if(!String.isEmpty(u.ContactId)){
                Contact c = [SELECT ID ,(SELECT ID,createddate FROM TNET_Activitys__r where name=:activityName) FROM Contact WHERE ID=:u.ContactId];
                List<TNET_Activity__c> taList = c.TNET_Activitys__r;
                if(taList==null||taList.size()<=0){
                    return 'Success';
                }else{
                    return 'Submitted on '+taList[0].createddate.format('MM/dd/YYYY');
                }
            }else{
                rs =  'Not Community User';
            }
        }catch(Exception e){
            rs = e.getMessage()+'\n'+e.getStackTraceString();
        }

        return rs;
    }
}