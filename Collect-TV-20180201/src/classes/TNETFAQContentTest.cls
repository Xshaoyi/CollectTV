/**
 * Created by sankur001 on 4/18/2017.
 */

@IsTest
public class TNETFAQContentTest {
    static testMethod void testBehavior() {
        TNET_TestUtil.TestFAQ();
        String faq = 'Contact Us';

        Test.startTest();

        TNETFAQContentCtrl.getFAQs(faq);

        Test.stopTest();
    }
}