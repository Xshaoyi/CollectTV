/**
 * Created by sankur001 on 4/18/2017.
 */

@IsTest
public class TNETTextTest {
    static testMethod void testBehavior() {
        TNET_TestUtil.testTextCarousel();

        Test.startTest();

        TNETTextCtrl.getBannerHeadings();

        Test.stopTest();

    }
}