/**
 * Created by sankur001 on 4/18/2017.
 */
public with sharing class TNET_TestUtil {

    public static void TestHomeBannerHeading() {
        List<TNET_Banner_Heading__c> bannerList = new List<TNET_Banner_Heading__c>();
        TNET_Banner_Heading__c banner1 = new TNET_Banner_Heading__c();
        banner1.TNET_Title__c = 'Welcome to PwC1';
        banner1.TNET_Type__c = 'TNET';
        banner1.TNET_Order__c = 1;
        banner1.TNET_Heading_For_Banner__c = 'Hello PwC1';
        banner1.TNET_Description__c = 'This is a test banner for PwC1';
        banner1.TNET_Is_Active__c = true;
        bannerList.add(banner1);
        TNET_Banner_Heading__c banner2 = new TNET_Banner_Heading__c();
        banner2.TNET_Title__c = 'Welcome to PwC2';
        banner2.TNET_Type__c = 'TNET';
        banner2.TNET_Order__c = 2;
        banner2.TNET_Heading_For_Banner__c = 'Hello PwC2';
        banner2.TNET_Description__c = 'This is a test banner for PwC1';
        banner2.TNET_Is_Active__c = true;
        bannerList.add(banner2);
        TNET_Banner_Heading__c banner3 = new TNET_Banner_Heading__c();
        banner3.TNET_Title__c = 'Welcome to PwC1';
        banner3.TNET_Type__c = 'TNET';
        banner3.TNET_Order__c = 3;
        banner3.TNET_Heading_For_Banner__c = 'Hello PwC1';
        banner3.TNET_Description__c = 'This is a test banner for PwC1';
        banner3.TNET_Is_Active__c = true;
        bannerList.add(banner3);
        insert bannerList;

        Attachment att = new Attachment();
        att.Name = 'Test Attachment.JPG';
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        att.Body = bodyBlob;
        att.ContentType = 'image';
        att.ParentId = banner1.Id;
        insert att;

    }

    public static void TestPageBannerHeading() {
        List<TNET_Banner_Heading__c> bannerList = new List<TNET_Banner_Heading__c>();
        TNET_Banner_Heading__c banner1 = new TNET_Banner_Heading__c();
        banner1.TNET_Title__c = 'Nationwide Warranty';
        banner1.TNET_Type__c = 'TNET Page';
        banner1.TNET_Heading_For_Banner__c = 'Nationwide Warranty';
        banner1.TNET_Description__c = 'This is a test banner for PwC1';
        banner1.TNET_Is_Active__c = true;
        bannerList.add(banner1);
        insert bannerList;

        Attachment att = new Attachment();
        att.Name = 'Test Attachment.JPG';
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        att.Body = bodyBlob;
        att.ContentType = 'image';
        att.ParentId = banner1.Id;
        insert att;

    }

    public static void TestTileBannerHeading() {
        List<TNET_Banner_Heading__c> bannerList = new List<TNET_Banner_Heading__c>();
        TNET_Banner_Heading__c banner1 = new TNET_Banner_Heading__c();
        banner1.TNET_Title__c = 'Nationwide Warranty';
        banner1.TNET_Type__c = 'TNET Tiles';
        banner1.TNET_Heading_For_Banner__c = 'Nationwide Warranty';
        banner1.TNET_Description__c = 'This is a test banner for PwC1';
        banner1.TNET_Is_Active__c = true;
        banner1.TNET_Order__c = 1;
        bannerList.add(banner1);
        insert bannerList;

        Attachment att = new Attachment();
        att.Name = 'Test Attachment.JPG';
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        att.Body = bodyBlob;
        att.ContentType = 'image';
        att.ParentId = banner1.Id;
        insert att;

    }

    public static void TestFAQ() {
        List<TNET_FAQ__c> faqList = new List<TNET_FAQ__c>();
        TNET_FAQ__c faq = new TNET_FAQ__c();
        faq.TNET_FAQ_Title__c = 'Contact Us';
        //faq.TNET_FAQ_Number__c = '1';
        faq.TNET_FAQ_Type__c = 'Contact Us';
        faqList.add(faq);
        insert faqList;
    }

    public static void TestVVCarousel() {
        List<TNET_Banner_Heading__c> bannerList = new List<TNET_Banner_Heading__c>();
        TNET_Banner_Heading__c banner1 = new TNET_Banner_Heading__c();
        banner1.TNET_Title__c = 'Welcome to PwC1';
        banner1.TNET_Type__c = 'Virtual Vehicle';
        banner1.TNET_Image_URL__c='abc/com';
        banner1.TNET_Order__c = 1;
        banner1.TNET_Heading_For_Banner__c = 'Hello PwC1';
        banner1.TNET_Description__c = 'This is a test banner for PwC1';
        banner1.TNET_Is_Active__c = true;
        banner1.TNET_Video_URL__c='www.youtube.com';
        bannerList.add(banner1);
        insert bannerList;
    }

    public static void testTextCarousel() {
        List<TNET_Announcements__c> annList = new List<TNET_Announcements__c>();
        TNET_Announcements__c ann = new TNET_Announcements__c();
        ann.TNET_Description__c = 'Test annoncement';
        ann.TNET_Is_Active__c = true;
        ann.TNET_Start_Date__c=date.today().addDays(-20);
        ann.TNET_End_Date__c = date.today().addDays(20);
        ann.TNET_Order__c = 1;
        annList.add(ann);
        insert annList;
    }

    public static void testDocSearch() {
        List<Document> docList = new List<Document>();
        Document document;
        document = new Document();
        document.Body = Blob.valueOf('Some Text');
        document.ContentType = 'application/pdf';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        document.Name = 'AAP';
        document.FolderId = [select id from folder where name = 'TECHNET Community Documents'].id;
        docList.add(document);
        insert docList;
    }

    public static Contact testRoadHazard()
    {
        Account act = new Account();
        act.Name = 'ABC';

        Contact cnt = new Contact();
        cnt.Account = act;
        cnt.LastName = 'ABC';
        cnt.Title='CEO';
        cnt.Email = 'anksriva@gmail.com';
        cnt.Phone = '1223232223';
        cnt.Fax= '2334343';
        cnt.OtherStreet = 'Test';
        cnt.OtherCity = 'Alabama';
        cnt.OtherState = 'Florida';
        cnt.OtherPostalCode = '323322';
        cnt.MailingStreet='Test';
        cnt.MailingCity = 'Alabama';
        cnt.MailingState = 'Florida';
        cnt.MailingPostalCode = '323322';

        return cnt;
    }

    public static List<Tech_Net__c>  testGeoBatch(){
        List<Account> accList = [SELECT ID FROM Account LIMIT 1];
        Tech_Net__c tech_net = new Tech_Net__c();
        tech_net.Website_Display_Name__c='ABC';
        tech_net.Website_Primary_Phone__c='123';
        tech_net.Website_City__c = 'CEDARTOWN';
        tech_net.Website_State_Province__c = 'GA';
        tech_net.Website_Street__c = '1007 EAST AVE';
        tech_net.Website_Zip_Postal_Code__c = '30125';
        tech_net.Email__c ='abc@def.com';
        tech_net.Account_Name__c = accList[0].Id;

        insert tech_net;
        tech_net.Enrollment_Status__c = System.Label.TNET_Form_Status_Enrolled;
        update tech_net;
        List<Tech_Net__c> rsList = new List<Tech_Net__c>();
        rsList.add(tech_net);
        return rsList;

    }

    public static List<Tech_Net__c>  testTechNetDateCreated(){
        List<Account> accList = [SELECT ID FROM Account LIMIT 2];
        Tech_Net__c tech_net = new Tech_Net__c();
        tech_net.Website_Primary_Phone__c='123';
        tech_net.Website_City__c = 'CEDARTOWN';
        tech_net.Website_State_Province__c = 'GA';
        tech_net.Website_Street__c = '1007 EAST AVE';
        tech_net.Website_Zip_Postal_Code__c = '30125';
        tech_net.Account_Name__c = accList[1].Id;

        insert tech_net;
        tech_net.Enrollment_Status__c = System.Label.TNET_Form_Status_Enrolled;
        update tech_net;
        List<Tech_Net__c> rsList = new List<Tech_Net__c>();
        rsList.add(tech_net);
        return rsList;

    }

    public static void testProfileMenu()
    {
        List<TNET_Profile_Menu__c> pmList = new List<TNET_Profile_Menu__c>();
        TNET_Profile_Menu__c act = new TNET_Profile_Menu__c();
        act.Name = 'My Profile';
        act.Order__c = 1;
        act.path__c ='My-Shop';
        pmList.add(act);

        TNET_Profile_Menu__c act1 = new TNET_Profile_Menu__c();
        act1.Name = 'Chatter Groups';
        act1.Order__c = 1;
        act1.path__c ='My-Shop';
        pmList.add(act1);

        insert pmList;
       // return act;
    }

    public static List<TNETDellCorningFormCtrl.CartItems> testCartItems(List<TECHNET_Item__c> tiList)
    {
        List<TNETDellCorningFormCtrl.CartItems> cartItems = new List<TNETDellCorningFormCtrl.CartItems>();
        TNETDellCorningFormCtrl.CartItems act = new TNETDellCorningFormCtrl.CartItems();
        act.Name = 'Floor Mat';
        act.cost = 49.99;
        act.quantity =1;
        act.id = tiList[0].id;
        act.orderAmount = 49.99;
        cartItems.add(act);

        TNETDellCorningFormCtrl.CartItems act1 = new TNETDellCorningFormCtrl.CartItems();
        act1.Name = 'Floor Mat';
        act1.cost = 59.99;
        act1.quantity =1;
        act1.id = tiList[1].id;
        act1.orderAmount = 59.99;
        cartItems.add(act1);

        return cartItems;
    }
    public static List<TNETDellCorningFormCtrl.StaticCling> testClings()
    {
        List<TNETDellCorningFormCtrl.StaticCling> cartItems = new List<TNETDellCorningFormCtrl.StaticCling>();
        TNETDellCorningFormCtrl.StaticCling act = new TNETDellCorningFormCtrl.StaticCling();
        act.itemName = 'test';
        act.isBusName = false;
        act.isAddress = false;
        act.isPhone = false;
        act.busName = 'isPhone';
        act.phone = 'isPhone';
        act.street = 'isPhone';
        act.city = 'isPhone';
        act.state = 'isPhone';
        act.zip = 'isPhone';

        cartItems.add(act);



        return cartItems;
    }
    public static User  createCommunityUser(String accId){
        List<Account> accList = [SELECT ID FROM Account LIMIT 1];
        Id p = [select id from profile where name='TECHNET Community User'].id;



        Contact con = new Contact(LastName ='testCon',AccountId = accId,Email='test123@noemail.com',Phone='123456789');
        insert con;
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,Date_in_Position__c=System.today(),
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');

        insert user;
        return user;

    }

    public static List<TECHNET_Item__c>  testItemMenu(String recType)
    {
        Id itemRecTypeId = Schema.SObjectType.TECHNET_Item__c.getRecordTypeInfosByName().get(recType).getRecordTypeId();

        List<TECHNET_Item__c> pmList = new List<TECHNET_Item__c>();
        TECHNET_Item__c act = new TECHNET_Item__c();
        act.Name = 'Floor Mat';
        act.Description__c = 'A mat to keep customer car clean during service';
        act.TNET_Is_Active__c =true;
        act.Item_Number__c = '123456';
        act.Max_Quantity__c = 10;
        act.Price_Per_Unit__c = 49.99;
        act.Unit_Type__c = '100 Mats';
        act.RecordTypeId = itemRecTypeId;
        pmList.add(act);

        TECHNET_Item__c act1 = new TECHNET_Item__c();
        act1.Name = 'Floor Mat1';
        act1.Description__c = 'A mat to keep customer car clean during service';
        act1.TNET_Is_Active__c =true;
        act1.Item_Number__c = '123457';
        act1.Max_Quantity__c = 12;
        act1.Price_Per_Unit__c = 59.99;
        act1.Unit_Type__c = '200 Mats';
        act1.RecordTypeId = itemRecTypeId;
        pmList.add(act1);

        insert pmList;
        return pmList;
    }
    
}