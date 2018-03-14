/**
 * Created by yshao009 on 5/2/17.
 */
@IsTest
public with sharing class TNETPromotionsCtrlTest {
    static testMethod void testBehavior(){
        TECHNET_Promotion__c tp = new TECHNET_Promotion__c();
        tp.Start_Date__c = System.today().addDays(-1);
        tp.End_Date__c = System.today();
        insert tp;
        TNETPromotionsCtrl.getPrograms();
    }
}