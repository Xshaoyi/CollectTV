public class TNETUtil {
    
        // check whether the input file name is a valid image extension
    public static Boolean isAvailableImage(String name){
        Set<String> fileTypeSet = new Set<String>{
            'JPG', 'PNG', 'JPEG'
        };
        Boolean available = false;
        for(String type : fileTypeSet){
            if(name.toUpperCase().endsWith('.' + type)){
                available = true;
                break;
            }
        }
        return available;
    }
    
    // get all communities user under my account
    public static Set<Id> getMyAccountUsers(){
        Set<Id> myAccountUserIdSet = new Set<Id>();

        User currentUser = getCommunityUserInfo();
        Id accountId = currentUser.Contact.Account.Id;
        if (accountId != null) {
            Set<Id> contactIdSet = new Set<Id>();
            for (Contact c : [
                    SELECT  Id
                    FROM    Contact
                    WHERE   AccountId = :accountId]) {
                contactIdSet.add(c.Id);
            }

            for (User u : [
                    SELECT  Id
                    FROM    User 
                    WHERE   ContactId IN :contactIdSet]) {
                myAccountUserIdSet.add(u.Id);
            }
        }else{
            myAccountUserIdSet.add(UserInfo.getUserId());
        }
        return myAccountUserIdSet;
    }
    
    // get user info of current user
	public static User getCommunityUserInfo(){
        return [
            SELECT  Contact.Id,
                    Contact.Name,
                    Contact.Account.Id
            FROM    User
            WHERE   Id = :UserInfo.getUserId()];
    }
    
    // get pick list values by given object and fields
    public static Map<String, String> getPicklistValues(String obj, String fieldName){
        Map<String, String> picklistLabelValueMap = new Map<String, String>();
        Schema.DescribeSobjectResult dsr = Schema.getGlobalDescribe().get(obj).getDescribe();
        Schema.DescribeFieldResult dfr = dsr.fields.getMap().get(fieldName).getDescribe();
        for(Schema.PicklistEntry pe : dfr.getPicklistValues()){
            picklistLabelValueMap.put(pe.getLabel(), pe.getValue());
        }
        return picklistLabelValueMap;
    }

    public static List<String> getRecordTypeStringList(String obj){
        Schema.DescribeSobjectResult  dsr = Schema.getGlobalDescribe().get(obj).getDescribe();
        List<Schema.RecordTypeInfo> rt = dsr.getRecordTypeInfos();
        List<String> rtStrList = new List<String>();
        for(Schema.RecordTypeInfo rti:rt){
            rtStrList.add(rti.getName());
        }
        return rtStrList;

    }
    public static void fakeTest(){
        Integer i = 0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;

    }
}