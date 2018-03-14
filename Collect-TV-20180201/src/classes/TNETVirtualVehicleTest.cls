/**
 * Created by sankur001 on 4/18/2017.
 */

@IsTest
public class TNETVirtualVehicleTest {
    static testMethod void testBehavior() {
        TNET_TestUtil.TestVVCarousel();
        String label = 'Virtual Vehicle';

        Test.startTest();

        TNETVirtualVehicleCtrl.getBannerHeadings(label);

        Test.stopTest();
    }
}