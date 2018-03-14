/**
 * Created by sankur001 on 5/2/2017.
 */

@IsTest
private class TNETProfileMenuTest {
    static testMethod void testBehavior() {
        TNET_TestUtil.testProfileMenu();

        Test.startTest();

        TNETProfileMenuCtrl.getUserInfo();

        Test.stopTest();
    }
}