/**
 * Created by sankur001 on 4/28/2017.
 */

@IsTest(SeeAllData = true)
private class TNETRoadHazardFormTest {
    static testMethod void testBehavior() {
        Contact dealer = TNET_TestUtil.testRoadHazard();
        String choice = 'Yes';
        String dealerName = 'AAP Dealer';

        Test.startTest();

        TNETRoadHazardFormCtrl.sendEmail(dealer,choice,dealerName);
        //TNETRoadHazardFormCtrl.getInitInfo();

        Test.stopTest();
    }
    static testMethod void testGetInitInfo() {
        List<Tech_Net__c> rsList = TNET_TestUtil.testTechNetDateCreated();
        User user = TNET_TestUtil.createCommunityUser(rsList[0].Account_Name__c);
        system.runAs(user) {
            TNETRoadHazardFormCtrl.getInitInfo();
        }
    }
}