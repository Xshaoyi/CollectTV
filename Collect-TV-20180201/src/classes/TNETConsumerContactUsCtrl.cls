public with sharing class TNETConsumerContactUsCtrl {
    
    @AuraEnabled
    public static void sendEmail (String name, String street, String city,String state, String zip, String phone, String email, String subject, String comments){
        try{
            List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();     
            
            // Step 1: Create a new Email
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            System.debug('<<<inside TNETConsumerContactUsCtrl >>>'+name);
            // Step 2: Set list of people who should get the email
            List<String> sendTo = new List<String>();
            sendTo.add(Label.TNET_SendToAddress); // This needs to be changed to suppport@technetprofessional.com//UserInfo.getUserEmail()
            //we also need to add CC to the email.
            mail.setToAddresses(sendTo);
            mail.setSenderDisplayName(email);
            // Step 3: Set who the email is sent from
            mail.setReplyTo(email);
           // mail.setSenderDisplayName('TECHNET Support');
            
            // Step 4. Set email contents - you can use variables!
            String mSubject = 'TECHNET Contact Us - Consumer';
            EmailTemplate tempID = [SELECT Id,HTMLValue,Name FROM EmailTemplate WHERE Id =:Label.TNET_ContactUsEmailTemplateId];
            System.debug('Value'+tempId);
            //System.debug('Dealer'+dealer);
            String mbody = tempID.HTMLValue;
            mbody = mbody.replace('SUBJECT', subject);
            mbody = mbody.replace('NAME', name);  
            mbody = mbody.replace('PHONE', phone);
            mbody = mbody.replace('EMAIL', email);
            mbody = mbody.replace('STREET', street);
            mbody = mbody.replace('CITY', city);
            mbody = mbody.replace('STATE', state);
            mbody = mbody.replace('ZIP', zip); 
            mbody = mbody.replace('COMMENTS', comments);
            
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

    @AuraEnabled
    public static List<String> getStates(){
        Map<String, String> stateMap = TNETUtil.getPicklistValues('Tech_Net__c','Website_State_Province__c');
        return new List<String>(stateMap.keySet());
    }
        
}