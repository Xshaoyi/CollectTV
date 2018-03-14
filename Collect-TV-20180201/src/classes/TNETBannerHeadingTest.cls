/**
 * Created by sankur001 on 4/18/2017.
 */

@IsTest
public class TNETBannerHeadingTest {

    static testMethod void testHomeBanners() {
        TNET_TestUtil.TestHomeBannerHeading();

        Test.startTest();

        TNETBannerHeadingCtrl.getBannerHeadings();

        Test.stopTest();

    }

    static testMethod void testPageBanners() {
        TNET_TestUtil.TestPageBannerHeading();
        String tabName = 'Nationwide-Warranty';
        Test.startTest();

        TNETBannerHeadingCtrl.getPageBanners(tabName);

        Test.stopTest();

    }

    static testMethod void testTileBanners() {
        TNET_TestUtil.TestTileBannerHeading();

        Test.startTest();

        TNETBannerHeadingCtrl.getBannerHeadingsForTileCmp();

        Test.stopTest();

    }

}