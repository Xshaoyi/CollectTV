/**
 * Created by sankur001 on 5/25/2017.
 */

public with sharing class TNETCareerModalCtrl {

    @AuraEnabled
    public static CareerModalWrapper getMemberDetails(){
        List<User> userList = [Select contact.AccountId,contact.Name,contact.Email,contact.Phone  from User where id =: Userinfo.getUserid()];
        Contact contact;
        if(userList.size()>0)
        {
            contact = new Contact();
            contact.LastName  = userList[0].contact.Name;
            contact.Email = userList[0].contact.Email;
            contact.Phone = userList[0].contact.Phone;
        }

        Set<Id> accountIds = new Set<Id>();
        for(User u : userList) {
            accountIds.add(u.contact.AccountId);
        }
        //AAP IT team confirmed that there will not be 2 Technet Forms with Status = 'Enrolled'. If there are, then we simply pick up the first form.
        List<Tech_Net__c> technetList = [Select id, Name from Tech_Net__c where Account_Name__c IN: accountIds AND Enrollment_Status__c =: System.Label.TNET_Form_Status_Enrolled order by createddate desc];

        List<Tech_Net__c> rs = [Select Id, Website_Display_Name__c,Website_Street__c, Website_City__c, Website_State_Province__c,
                Website_Zip_Postal_Code__c from Tech_Net__c where Id IN: technetList];

        Tech_Net__c tnetObj = rs[0];

        CareerModalWrapper pw = new CareerModalWrapper();
        Map<String, String> stateMap = TNETUtil.getPicklistValues('Tech_Net__c','Website_State_Province__c');
        pw.statelist = new List<String>(stateMap.keySet());
        pw.technetObj = tnetObj;
        pw.cnt = contact;
        System.debug(pw);
        return pw;
    }

    @AuraEnabled
    public static void sendEmail (String content){

        try{
            CareerModalWrapper cw = (CareerModalWrapper)System.JSON.deserialize(content, CareerModalWrapper.class);

            List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();

            // Step 1: Create a new Email
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            // Step 2: Set list of people who should get the email
            List<String> sendTo = new List<String>();
            sendTo.add(Label.TNET_CB_Send_To_Address); // This needs to be changed to suppport@technetprofessional.com//UserInfo.getUserEmail()
            //we also need to add CC to the email.
            mail.setToAddresses(sendTo);

            // Step 3: Set who the email is sent from
            mail.setReplyTo(cw.cnt.Email);
            // mail.setSenderDisplayName('TECHNET Support');

            // Step 4. Set email contents - you can use variables!
            String mSubject = 'CareerBuilder Credential Request: '+cw.cnt.LastName;
            EmailTemplate tempID = [SELECT Id,HTMLValue,Name FROM EmailTemplate WHERE developername =:Label.TNET_Career_Builder_Email_Id];

            String mbody = tempID.HTMLValue;
            mbody = mbody.replace('SUBJECT', mSubject);
            mbody = mbody.replace('NAME', cw.cnt.LastName);
            mbody = mbody.replace('EMAIL', cw.cnt.Email);
            mbody = mbody.replace('STREET', cw.technetObj.Website_Street__c);
            mbody = mbody.replace('CITY', cw.technetObj.Website_City__c);
            mbody = mbody.replace('STATE', cw.technetObj.Website_State_Province__c);
            mbody = mbody.replace('ZIP', cw.technetObj.Website_Zip_Postal_Code__c);
            mbody = mbody.replace('PHONE', cw.cnt.Phone);
            mbody = mbody.replace('SHOP', cw.technetObj.Website_Display_Name__c);

            System.debug('mbody'+mbody);

            mail.setSubject(mSubject);
            mail.setHtmlBody(mbody);

            // Step 5. Add your email to the master list
            mails.add(mail);

            // Step 6: Send all emails in the master list
            Messaging.sendEmail(mails);

        } catch (Exception ex){

        }
    }

    public class CareerModalWrapper {
        @AuraEnabled
        public  Tech_Net__c technetObj {get; set;}
        @AuraEnabled
        public  Contact cnt {get; set;}
        @AuraEnabled
        public List<String> statelist{get;set;}
    }
}