/**
 * Created by sankur001 on 4/28/2017.
 */

@IsTest
private class TNETSearchResultsTest {
    static testMethod void testBehavior() {
        TNET_TestUtil.testDocSearch();
        String keyword = 'AAP';
        Test.startTest();

        TNETSearchResultsCtrl.search(keyword);

        Test.stopTest();
    }
}