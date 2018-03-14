/* Created by Dev Boorla */
public without sharing class TNETMemberMyProfileCtrl {

  // @AuraEnabled
  // public static String userImage{get;set;}

    @AuraEnabled
    public static MyProfileWrapper getMemberDetails(){
        System.debug('~~~~Inside getMemberDetails~~~~');
        
        List<User> userList = [Select contact.AccountId  from user where id =: Userinfo.getUserid()];
        Set<Id> accountIds = new Set<Id>();
		System.debug('User List -->'+userList);
		for(User u : userList) {
		  	 accountIds.add(u.contact.AccountId);
		}
		System.debug('Account Ids  -->'+accountIds);

        MyProfileWrapper mp = new MyProfileWrapper();
        //GET STATE lIST
        Map<String, String> stateMap = TNETUtil.getPicklistValues('Tech_Net__c','Website_State_Province__c');
        mp.statelist = new List<String>(stateMap.keySet());
		//AAP IT team confirmed that there will not be 2 Technet Forms with Status = 'Enrolled'. If there are, then we simply pick up the first form.  
		List<Tech_Net__c> technetList = [Select id, Name from Tech_Net__c where Account_Name__c IN: accountIds AND Enrollment_Status__c =: System.Label.TNET_Form_Status_Enrolled order by createddate desc];
		
		System.debug('TNET LIST -->'+technetList);
        List<Tech_Net__c> rs = [Select Id, Account_Name__c, Website_Display_Name__c, Website__c, Website_Primary_Phone__c, 
                Website_Street__c, Website_City__c, Website_State_Province__c, Website_Zip_Postal_Code__c, 
                Website_Country__c, Driving_Directions__c, General_Repair__c, Collision_Repair__c, 
                Import_Specialist__c, Hybrid_Specialist__c, Heavy_Duty_Specialist__c, Electrical_Specialist__c,
                 Diesel_Specialist__c, Diagnostic_Service_Computer_Diagnosti__c,
                 State_Inspections__c, Synchrony_Car_Care__c, Shuttle_Service__c, Tire_Service__c,
                 Alignment_Service_or_Wheel_Alignment__c, RV_Service__c, Towing_Service__c,
                TNET_36_36_Badge__c,TNET_ASE_Certified_Badge__c,TNET_BBB_Badge__c,TNET_MAP_Badge__c,TNET_More_Shop_Info__c,
                TNET_RepairPal_Badge__c,TNET_Service_Details__c,
                (SELECT id from Attachments ORDER BY CreatedDate DESC LIMIT 1)
                 from Tech_Net__c where Id IN: technetList];
        
        Tech_Net__c tnetObj = rs[0];
        mp.tech_net = tnetObj;

       // List<Attachment> atmList = [SELECT id from Attachment WHERE parentId =:tnetObj.Id ORDER BY CreatedDate DESC LIMIT 1];
        //userImage = '/servlet/servlet.FileDownload?file='+atmList[0].Id;
                //'https://'+Label.TNET_Communities_URL +'/sfc/servlet.shepherd/version/download/'+atmList[0].Id;
        System.debug('TNET OBJ-->'+tnetObj);

     /*   MyProfileWrapper pw = new MyProfileWrapper();
        pw.tech_net = tnetObj;
        pw.userImage = '/servlet/servlet.FileDownload?file='+atmList[0].Id;
        return pw; */

        return mp;
    }

    @AuraEnabled
    public static Tech_Net__c getMemberDetailsById(String theId){
        List<Tech_Net__c> rs = [Select Id, Account_Name__c, Website_Display_Name__c, Website__c, Website_Primary_Phone__c,
                Website_Street__c, Website_City__c, Website_State_Province__c, Website_Zip_Postal_Code__c,
                Website_Country__c, Driving_Directions__c, General_Repair__c, Collision_Repair__c,
                Import_Specialist__c, Hybrid_Specialist__c, Heavy_Duty_Specialist__c, Electrical_Specialist__c,
                Diesel_Specialist__c, Diagnostic_Service_Computer_Diagnosti__c,
                State_Inspections__c, Synchrony_Car_Care__c, Shuttle_Service__c, Tire_Service__c,
                Alignment_Service_or_Wheel_Alignment__c, RV_Service__c, Towing_Service__c,
                TNET_36_36_Badge__c,TNET_ASE_Certified_Badge__c,TNET_BBB_Badge__c,TNET_MAP_Badge__c,TNET_More_Shop_Info__c,
                TNET_RepairPal_Badge__c,TNET_Service_Details__c
        from Tech_Net__c where Id =:theId];

        Tech_Net__c tnetObj = rs[0];
        System.debug('TNET OBJ-->'+tnetObj);
        return tnetObj;
    }

    @AuraEnabled
    public static String updateMemberDetails (Tech_Net__c technetObj){
        String resultStatus = 'Success';
        try{
            System.debug('<<<Inside updateMemberDetails No Updates on acc>>>'+technetObj);
    //       Below code needs to be enabled if we want to update any fields directly on Account. 
    //       However note that all future methods etc will run if we do so 
    //         List<Account> accList = [Select Id, Website from Account where id =: technetObj.Account_Name__c];
    //         for(Account acc : accList) {
    // 			acc.Website = technetObj.Website__c;
    // 		}
    // 		update accList;
    		
            List<Tech_Net__c> tnetList = new List<Tech_Net__c>();
            tnetList.add(technetObj);
            //update tnetList;
            Database.SaveResult[] srList = null;
            try{
            srList = Database.update(tnetList);
            }catch(DMLException de){
                System.debug('~~~inside Catch~~~');
                //de.getStackTraceString();
                resultStatus = de.getStackTraceString()+'\n Cause:'+de.getMessage();
                return resultStatus;
            }
            // Iterate through each returned result
            for (Database.SaveResult sr : srList) {
                if (!sr.isSuccess()) {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Fields that affected this error: ' + err.getFields());
                    }
                }
            }
        } catch (Exception ex){
            resultStatus = ex.getStackTraceString();
        }
        return resultStatus;
    }
    
    //This is used for testing purposes only.
     @AuraEnabled
    public static List<Tech_Net__c> getDetails(){
        System.debug('~~~~Inside getMemberDetails~~~~');
        List<Tech_Net__c> rs = [Select Id, Account_Name__c, Website_Display_Name__c, Website__c, Website_Primary_Phone__c, 
                Website_Street__c, Website_City__c, Website_State_Province__c, Website_Zip_Postal_Code__c, 
                Website_Country__c, Driving_Directions__c, General_Repair__c, Collision_Repair__c, 
                Import_Specialist__c, Hybrid_Specialist__c, Heavy_Duty_Specialist__c, Electrical_Specialist__c,
                 Diesel_Specialist__c, Diagnostic_Service_Computer_Diagnosti__c,
                 State_Inspections__c, Synchrony_Car_Care__c, Shuttle_Service__c, Tire_Service__c,
                 Alignment_Service_or_Wheel_Alignment__c, RV_Service__c, Towing_Service__c
                 from Tech_Net__c where Id = 'a1C4D000000acDj'];
        
        
        return rs;//Need to update this 
    }

    @AuraEnabled
    public static String uploadImage(String base64Data, String contentType, Tech_Net__c technetObj,String fileId){
        System.debug(LoggingLevel.INFO, '*** contentType: ' + contentType);
        System.debug(LoggingLevel.INFO, '*** base64Data: ' + base64Data);
        String rs='';
        try{
            Account acc = [SELECT name from Account WHERE ID =:technetObj.Account_Name__c];
            if(String.isEmpty(fileId)){
                //base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
                List<Attachment> oldAttachList = [SELECT id from Attachment where parentId=:technetObj.id and Description = :Label.TNET_Shop_Profile_Img_Description];
                delete oldAttachList;
                Attachment a = new Attachment();
                a.parentId = technetObj.id;

                a.Body = EncodingUtil.convertFromHex(base64Data);
                a.Name =  acc.name + Label.TNET_Profile_photo_suffix;
                a.ContentType = contentType;
                a.Description = Label.TNET_Shop_Profile_Img_Description;

                insert a;

                String imageURL = a.Id;
                return imageURL;
            }else{
                Attachment a = [
                        SELECT Id, Body
                        FROM Attachment
                        WHERE Id = :fileId
                ];

                String existingBody = EncodingUtil.convertToHex(a.Body);
                a.Body = EncodingUtil.convertFromHex(existingBody + base64Data);

                update a;
                return fileId;
            }
        }catch (Exception e){
            rs = e.getLineNumber()+':'+e.getStackTraceString();
        }
        return rs;
       /* String photoUrl = '';
        if(!Test.isRunningTest()){
            ConnectApi.BinaryInput headshotFile = new ConnectApi.BinaryInput(EncodingUtil.convertFromHex(base64Data), contentType, 'Pic_' + technetObj.Website_Display_Name__c);
            //ConnectApi.BinaryInput headshotFile = new ConnectApi.BinaryInput(Blob.valueOf(base64Data), contentType, 'Pic_' + String.valueOf(UserInfo.getUserId()));
            ConnectApi.Photo photo = ConnectApi.UserProfiles.setPhoto(null, String.valueOf(UserInfo.getUserId()), headshotFile);
            photoUrl = photo.largePhotoUrl;
        }
        return photoUrl; */
    }

    public class MyProfileWrapper {
        @AuraEnabled
        public Tech_Net__c tech_net {get; set;}
        @AuraEnabled
        public List<String> statelist {get; set;}
    }
}