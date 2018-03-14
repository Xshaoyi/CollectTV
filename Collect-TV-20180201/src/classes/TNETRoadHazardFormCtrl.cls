public with sharing class TNETRoadHazardFormCtrl {

    @AuraEnabled
    public static void sendEmail (Contact dealer, String choice,String dealerName){
        try{
            List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();

            // Step 1: Create a new Email
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            System.debug('dealer1'+dealer);
            System.debug('dealerEmail'+dealer.email);
            // Step 2: Set list of people who should get the email
            List<String> sendTo = new List<String>();
            sendTo.add(dealer.email);
            // if(Label.TNET_RoadHazardSendToAddress<>null) sendTo.add(Label.TNET_RoadHazardSendToAddress);
            mail.setToAddresses(sendTo);

            // Step 3: Set who the email is sent from
            mail.setReplyTo('support@technetprofessional.com.dev'); // change it with your mail address.Label.TNET_RoadHazardSendFromAddress
            mail.setSenderDisplayName('TECHNET Support');

            // Step 4. Set email contents - you can use variables!
            String mSubject = 'TECHNET Road Hazard Registration';
            EmailTemplate tempID = [SELECT Id,HTMLValue,Name FROM EmailTemplate WHERE Id =:Label.TNET_RoadHazardEmailId];
            System.debug('Value'+tempId);
            System.debug('Dealer'+dealer);
            String mbody = tempID.HTMLValue;
            mbody = mbody.replace('DEALER_NAME',dealerName);
            mbody = mbody.replace('CONTACT',dealer.LastName);
            mbody = mbody.replace('TITLE',dealer.Title);
            mbody = mbody.replace('EMAIL',dealer.Email);
            mbody = mbody.replace('PHONE',dealer.Phone);
            mbody = mbody.replace('FAX',dealer.Fax);
            mbody = mbody.replace('OSTREET',dealer.OtherStreet);
            mbody = mbody.replace('OCITY',dealer.OtherCity);
            mbody = mbody.replace('OSTATE',dealer.OtherState);
            mbody = mbody.replace('OZIP',dealer.OtherPostalCode);
            mbody = mbody.replace('MSTREET',dealer.MailingStreet);
            mbody = mbody.replace('MCITY',dealer.MailingCity);
            mbody = mbody.replace('MSTATE',dealer.MailingState);
            mbody = mbody.replace('MZIP',dealer.MailingPostalCode);
            mbody = mbody.replace('CHOICE',choice);//(String.valueOf(choice)=='true')? 'Yes':'No'

            System.debug('mbody'+mbody);

            mail.setSubject(mSubject);
            mail.setHtmlBody(mbody);

            // Step 5. Add your email to the master list
            mails.add(mail);

            Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
            List<String> sendTo1 = new List<String>();
            sendTo1.add(Label.TNET_RoadHazardSendToAddress1);
            // if(Label.TNET_RoadHazardSendToAddress<>null) sendTo.add(Label.TNET_RoadHazardSendToAddress);
            mail1.setToAddresses(sendTo1);
            mail1.setReplyTo('support@technetprofessional.com.dev'); // change it with your mail address.Label.TNET_RoadHazardSendFromAddress
            mail1.setSenderDisplayName('TECHNET Support');
            mail1.setSubject(mSubject);
            mail1.setHtmlBody(mbody);
            mails.add(mail1);

            Messaging.SingleEmailMessage mail2 = new Messaging.SingleEmailMessage();
            List<String> sendTo2 = new List<String>();
            sendTo2.add(Label.TNET_RoadHazardSendToAddress2);
            // if(Label.TNET_RoadHazardSendToAddress<>null) sendTo.add(Label.TNET_RoadHazardSendToAddress);
            mail2.setToAddresses(sendTo2);
            mail2.setReplyTo('support@technetprofessional.com.dev'); // change it with your mail address.Label.TNET_RoadHazardSendFromAddress
            mail2.setSenderDisplayName('TECHNET Support');
            mail2.setSubject(mSubject);
            mail2.setHtmlBody(mbody);
            mails.add(mail2);
            // Step 6: Send all emails in the master list
            Messaging.sendEmail(mails);

        } catch (Exception ex){

        }
    }
    @AuraEnabled
    public static InitInfo getInitInfo(){
        InitInfo currentInitInfo = new InitInfo();
        currentInitInfo.shop = TNETMemberMyProfileCtrl.getMemberDetails().tech_net;
        currentInitInfo.userInfo = TNETProfileMenuCtrl.getUserInfo();
        Map<String, String> stateMap = TNETUtil.getPicklistValues('Tech_Net__c','Website_State_Province__c');
        currentInitInfo.statelist = new List<String>(stateMap.keySet());
        return currentInitInfo;
    }

    public class InitInfo{
        @AuraEnabled
        Tech_Net__c shop{get;set;}
        @AuraEnabled
        Object userInfo{get;set;}
        @AuraEnabled
        public List<String> statelist {get; set;}
    }
        
}