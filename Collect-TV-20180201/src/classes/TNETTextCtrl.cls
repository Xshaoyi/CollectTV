/**
 * Created by sankur001 on 4/5/2017.
 */

public with sharing class TNETTextCtrl {

    @AuraEnabled
    public static List<TNET_Announcements__c> getBannerHeadings() {
        Set<Id> bannerHeadingIdSet = new Set<Id>();
        //Date stDate = date.today().addDays(-30);
        //Date endDate = date.today().addDays(30);
        List<TNET_Announcements__c> bannerHeadingList = [
                SELECT TNET_Description__c
                FROM TNET_Announcements__c
                WHERE TNET_Is_Active__c = true
                AND TNET_Start_Date__c <= today
                AND TNET_End_Date__c >= today
                ORDER BY TNET_Order__c ASC
        ];

        return bannerHeadingList;
    }
}