/**
 * Created by sankur001 on 6/27/2017.
 */

@IsTest(SeeAllData = true)
private class TNETDellCorningFormTest {
    static testMethod void testBehavior() {
        String recType = 'Dell-Corning';
        TNET_TestUtil.testItemMenu(recType);
        Test.startTest();

        TNETDellCorningFormCtrl.getItemDetails(recType);

        Test.stopTest();
    }

    static testMethod void testProfile(){
        List<Tech_Net__c> rsList = TNET_TestUtil.testGeoBatch();
        User user = TNET_TestUtil.createCommunityUser(rsList[0].Account_Name__c);
        system.runAs(user) {
        Test.startTest();
        TNETDellCorningFormCtrl.getMemberDetails();
        Test.stopTest();
        }

    }

    static testMethod void testSendDetails(){
        String recType = 'Dell-Corning';
        List<TECHNET_Item__c> tiList = TNET_TestUtil.testItemMenu(recType);
        List<Tech_Net__c> rsList = TNET_TestUtil.testGeoBatch();
        User user = TNET_TestUtil.createCommunityUser(rsList[0].Account_Name__c);

        Tech_Net__c technetObj = rsList[0];
        List<TNETDellCorningFormCtrl.CartItems> cartItems = TNET_TestUtil.testCartItems(tiList);
        List<TNETDellCorningFormCtrl.StaticCling> cartClings = TNET_TestUtil.testClings();
       // String selectedItems = '{"name":"Floor Mat","cost":"49.99","quantity":"1","id":"'+ tiList[0].Id +'","orderAmount":"49.99"},{"name":"Floor Mat","cost":"59.99","quantity":"1","id":'+ tiList[1].Id +',"orderAmount":"59.99"}';
        String selectedItems = JSON.serialize(cartItems);
        String clingString = JSON.serialize(cartClings);
        Decimal cartAmount = 49.99;
        system.runAs(user) {
            Test.startTest();
            TNETDellCorningFormCtrl.getMemberDetails();
            TNETDellCorningFormCtrl.sendDetails(technetObj,selectedItems,cartAmount,recType,clingString);
            Test.stopTest();
        }

    }

}