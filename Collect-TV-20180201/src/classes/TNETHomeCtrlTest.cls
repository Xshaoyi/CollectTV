/**
 * Created by yshao009 on 5/2/17.
 */

@IsTest
private without sharing class TNETHomeCtrlTest {
    static testMethod void testHome() {
        Double lat = 37.4223895;
        Double lng = -122.0843123;

        Test.startTest();

        //TNETHomeCtrl.findShopByKeyWord(lat,lng,25);
        TNETHomeCtrl.getChatterGroups();
        TNETHomeCtrl.getConsumerTabs();
        TNETHomeCtrl.getMemberTabs();
        TNETHomeCtrl.fakeTest();
        TNETUtil.fakeTest();
        Test.stopTest();
    }
}