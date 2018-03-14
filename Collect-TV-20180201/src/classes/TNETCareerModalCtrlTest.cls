/**
 * Created by yshao009 on 6/28/17.
 */

@IsTest(SeeAllData = true)
private class TNETCareerModalCtrlTest {
    static testMethod void testBehavior() {
        List<Tech_Net__c> rsList = TNET_TestUtil.testGeoBatch();
        User user = TNET_TestUtil.createCommunityUser(rsList[0].Account_Name__c);
        system.runAs(user) {
            Test.startTest();
            TNETCareerModalCtrl.CareerModalWrapper gm = TNETCareerModalCtrl.getMemberDetails();
            TNETCareerModalCtrl.sendEmail(JSON.serialize(gm));

            Test.stopTest();
        }
    }
}