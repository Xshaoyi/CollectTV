/**
 * Created by sankur001 on 5/2/2017.
 */

@IsTest
private class TNETConsumerContactUsTest {
    static testMethod void testBehavior() {
        String name   = 'TECHNET User';
        String street = '1850 Big Island Drive';
        String city   = 'Jacksonville';
        String state  = 'Florida';
        String zip    = '12345';
        String phone  = '342342233';
        String email  = 'abc@xyz.com';
        String subject = 'Test Mail';
        String comments = 'Test comment';

        TNETConsumerContactUsCtrl.sendEmail(name,street,city,state,zip,phone,email,subject,comments);
    }
}