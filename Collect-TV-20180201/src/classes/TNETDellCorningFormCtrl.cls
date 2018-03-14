/**
 * Created by sankur001 on 6/8/2017.
 */

public with sharing class TNETDellCorningFormCtrl {

    @AuraEnabled
    public static List<TECHNET_Item__c> getItemDetails(String recType){

        Id itemRecTypeId = Schema.SObjectType.TECHNET_Item__c.getRecordTypeInfosByName().get(recType).getRecordTypeId();

        List<TECHNET_Item__c> itemList = [SELECT Id,Name,Description__c,Item_Number__c,
                                          Max_Quantity__c,Price_Per_Unit__c,Unit_Type__c,
                                          Hide_Display_Image__c,Hide_Item_Number__c,Hide_Description__c,Hide_Unit_Type__c,Requires_Additional_Static_Cling_Info__c,
                                          (SELECT id from Attachments ORDER BY CreatedDate DESC LIMIT 1)
                                          FROM TECHNET_Item__c WHERE TNET_Is_Active__c=TRUE AND RecordTypeId =:itemRecTypeId ORDER BY Display_Order__c ASC ];

        return itemList;
    }

    @AuraEnabled
    public static MyProfileWrapper getMemberDetails(){
        List<User> userList = [Select contact.AccountId  from user where id =: Userinfo.getUserid()];

        Set<Id> accountIds = new Set<Id>();
        MyProfileWrapper mp = new MyProfileWrapper();
        //GET STATE lIST
        Map<String, String> stateMap = TNETUtil.getPicklistValues('Tech_Net__c','Website_State_Province__c');
        mp.statelist = new List<String>(stateMap.keySet());

        for(User u : userList) {
            accountIds.add(u.contact.AccountId);
        }
        //AAP IT team confirmed that there will not be 2 Technet Forms with Status = 'Enrolled'. If there are, then we simply pick up the first form.
        List<Tech_Net__c> technetList = [Select Id, Website_Display_Name__c,CCDB_Account_Id__c,Email__c,
                                                Website_Street__c, Website_City__c, Website_State_Province__c,
                                                Website_Zip_Postal_Code__c,Website_Primary_Phone__c FROM
                                                Tech_Net__c where Account_Name__c IN: accountIds AND
                                                Enrollment_Status__c =: System.Label.TNET_Form_Status_Enrolled order by createddate desc];

        Tech_Net__c tnetObj = technetList[0];
        mp.tech_net = tnetObj;
        return mp;
    }

    @AuraEnabled
    public static void sendDetails (Tech_Net__c technetObj, String selectedItems,Decimal cartAmount,String recType,String staticClings){
       try {
            List<StaticCling> clingList = null;
            if(!String.isEmpty(staticClings)){
                clingList = (List<StaticCling>)System.JSON.deserialize(staticClings, List<StaticCling>.class);
            }
            List<CartItems> ciList = (List<CartItems>)System.JSON.deserialize(selectedItems, List<CartItems>.class);

            System.debug('ciList'+ciList);
            System.debug('clingList'+clingList);
            System.debug('technetObj'+technetObj);
            List<TECHNET_Transaction__c> tnetTxnsList = new List<TECHNET_Transaction__c>();

            Id ordRecTypeId = Schema.SObjectType.TECHNET_Order__c.getRecordTypeInfosByName().get(recType).getRecordTypeId();
            Id txnRecTypeId = Schema.SObjectType.TECHNET_Transaction__c.getRecordTypeInfosByName().get(recType).getRecordTypeId();

            TECHNET_Order__c tnetOrder = new TECHNET_Order__c();
            tnetOrder.TECHNET__c = technetObj.Id;
            tnetOrder.Total_Cost__c = cartAmount;
            tnetOrder.RecordTypeId = ordRecTypeId;

            insert tnetOrder;

            String orderTable = '';
            orderTable = '<table border="1"><caption>Order Details</caption><tr><th>Item Name</th><th>Unit Cost</th><th>Qty</th><th>Subtotal</th></tr>';

            for(CartItems ci :ciList)
            {
                TECHNET_Transaction__c tnetTxn = new TECHNET_Transaction__c();
                tnetTxn.Name = technetObj.Website_Display_Name__c+'-'+ci.name;
                tnetTxn.Transaction_Items__c = ci.id;
                tnetTxn.Transaction_Order__c = tnetOrder.id;
                tnetTxn.Order_Quantity__c    = ci.quantity;
                tnetTxn.RecordTypeId         = txnRecTypeId;
                tnetTxnsList.add(tnetTxn);
                orderTable += '<tr><td>' + ci.name + '</td><td>$' + ci.cost + '</td><td>' + ci.quantity + '</td><td>$' + ci.orderAmount + '</td></tr>';
            }
            insert tnetTxnsList;

            orderTable+='</table>';

            String clingHtml = '';
//           public String index {get;set;}
//                public Boolean isBusName {get;set;}
//            public Boolean isAddress {get;set;}
//            public Boolean isPhone {get;set;}
//            public String busName {get;set;}
//            public String phone {get;set;}
//            public String street {get;set;}
//            public String city {get;set;}
//            public String city {get;set;}
//            public String zip {get;set;}
            if(clingList != null){
                for(StaticCling sc:clingList){
                    clingHtml += '<div><b> '+ sc.itemName +' Label Information:</b></div>';
                    if(sc.isBusName){
                        clingHtml +=  '<div>Business Name: '+ sc.busName +'</div>';
                    }
                    if(sc.isPhone){
                        clingHtml +=  '<div>Phone Number: '+ sc.phone +'</div>';
                    }
                    if(sc.isAddress){
                        clingHtml +=  '<div>Street: '+ sc.street +'</div>';
                        clingHtml +=  '<div>City: '+ sc.city +'</div>';
                        clingHtml +=  '<div>State/Province: '+ sc.state +'</div>';
                        clingHtml +=  '<div>Zip/Postal Code: '+ sc.zip +'</div>';
                    }
                    clingHtml +='<br/>';
                }
            }


            List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();

            // Step 1: Create a new Email
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            // Step 2: Set list of people who should get the email
            List<String> sendTo = new List<String>();
            sendTo.addAll((Label.TNET_OrderFormSendToEmail).split(';'));
            mail.setToAddresses(sendTo);

            // Step 3: Set who the email is sent from
            mail.setReplyTo('support@technetprofessional.com.dev'); // change it with your mail address.Label.TNET_RoadHazardSendFromAddress
            mail.setSenderDisplayName('TECHNET Support');

            // Step 4. Set email contents - you can use variables!
            String mSubject = recType+' Order Purchase Details';
            EmailTemplate tempID = [SELECT Id,HTMLValue,Name FROM EmailTemplate WHERE Id =:Label.TNET_Order_Form_Email_Id];
            System.debug('Value'+tempId);

            String orderLink = 'https://'+Label.TNET_Content_URL +'.my.salesforce.com/' +tnetOrder.Id;
            String ecMsg = '<a style=\'color:1B2BE8\' target="_blank" href="'+orderLink+'">'+'Click Here'+'</a>';

            String mbody = tempID.HTMLValue;
            mbody = mbody.replace('BUSINESS_NAME',technetObj.Website_Display_Name__c);
            mbody = mbody.replace('EMAIL',technetObj.Email__c);
            mbody = mbody.replace('PHONE',technetObj.Website_Primary_Phone__c);
            mbody = mbody.replace('STREET', technetObj.Website_Street__c);
            mbody = mbody.replace('CITY', technetObj.Website_City__c);
            mbody = mbody.replace('STATE',technetObj.Website_State_Province__c);
            mbody = mbody.replace('ZIP', technetObj.Website_Zip_Postal_Code__c);
            mbody = mbody.replace('ORDERTABLE',orderTable);
            mbody = mbody.replace('TOTALAMOUNT','$'+cartAmount.toPlainString());
            mbody = mbody.replace('ORDERDETAILS',ecMsg);
            mbody = mbody.replace('STATICCLINGS',clingHtml);
            mail.setSubject(mSubject);
            mail.setHtmlBody(mbody);

            // Step 5. Add your email to the master list
            mails.add(mail);

            // Step 6: Send all emails in the master list
            Messaging.sendEmail(mails);

        } catch (Exception ex){

        }
    }

    public class CartItems{
        public String name {get;set;}
        public Decimal cost {get;set;}
        public Integer quantity {get;set;}
        public Id id {get;set;}
        public Decimal orderAmount {get;set;}
    }

    public class StaticCling{
        public String itemName {get;set;}
        public Boolean isBusName {get;set;}
        public Boolean isAddress {get;set;}
        public Boolean isPhone {get;set;}
        public String busName {get;set;}
        public String phone {get;set;}
        public String street {get;set;}
        public String city {get;set;}
        public String state {get;set;}
        public String zip {get;set;}
    }
    public class MyProfileWrapper {
        @AuraEnabled
        public Tech_Net__c tech_net {get; set;}
        @AuraEnabled
        public List<String> statelist {get; set;}
    }
}