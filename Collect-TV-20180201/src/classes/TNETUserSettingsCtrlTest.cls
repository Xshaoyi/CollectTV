/**
 * Created by yshao009 on 6/28/17.
 */

@IsTest
private class TNETUserSettingsCtrlTest {
    static testMethod void testBehavior() {
        NetworkMember nm = TNETUserSettingsCtrl.getUserDetails();
        TNETUserSettingsCtrl.saveDetails(nm);
    }
}