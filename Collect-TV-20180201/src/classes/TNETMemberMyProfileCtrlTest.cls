/**
 * Created by yshao009 on 5/2/17.
 */
@IsTest(SeeAllData = true)
private class TNETMemberMyProfileCtrlTest {
    static testMethod void testProfile(){
        List<Tech_Net__c> rsList = TNET_TestUtil.testGeoBatch();
        User user = TNET_TestUtil.createCommunityUser(rsList[0].Account_Name__c);
        system.runAs(user) {
            TNETMemberMyProfileCtrl.getMemberDetails();
            TNETMemberMyProfileCtrl.updateMemberDetails(rsList[0]);
            TNETMemberMyProfileCtrl.getDetails();
            String attId = TNETMemberMyProfileCtrl.uploadImage('ffd8ffe000ffd9','png',rsList[0],null);
            TNETMemberMyProfileCtrl.uploadImage('ffd8ffe000ffd9','png',rsList[0],attId);
            TNETMemberMyProfileCtrl.uploadImage('ffd8ffe000ffd9','png',rsList[0],null);
            TNETMemberMyProfileCtrl.getMemberDetailsById(rsList[0].id);
        }

    }
}