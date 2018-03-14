/**
 * Created by yshao009 on 7/4/17.
 */
@IsTest(SeeAllData = true)
public with sharing class TNETAcknowledgementCtrlTest {
    static testMethod void testBehavior() {
        List<Tech_Net__c> rsList = TNET_TestUtil.testGeoBatch();
        User user = TNET_TestUtil.createCommunityUser(rsList[0].Account_Name__c);
        TNETAcknowledgementCtrl.acknowledge('Just a test abc');
        TNETAcknowledgementCtrl.getInitData('Just a test abc');
        system.runAs(user) {

            Test.startTest();
            TNETAcknowledgementCtrl.acknowledge('Just a test abc');
            TNETAcknowledgementCtrl.getInitData('Just a test abc');
            Test.stopTest();
        }
    }
}