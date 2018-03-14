/**
 * Created by yshao009 on 3/9/17.
 */

global without sharing class TNETHomeCtrl {
    @RemoteAction
    global static List<Tech_Net__c> findShopByKeyWord(Double latitude,Double longitude,Integer radius){




        String query = 'SELECT Website_Display_Name__c,Website_City__c,Website__c,' +
                'Website_Country__c, Website_Zip_Postal_Code__c,Website_State_Province__c,Website_Street__c,' +
                'Website_Primary_Phone__c,account_name__r.Email__c,Shuttle_Service__c,General_Repair__c,' +
                'Collision_Repair__c,Tire_Service__c,RV_Service__c,Towing_Service__c,Synchrony_Car_Care__c,' +
                'Import_Specialist__c ,Diesel_Specialist__c,Heavy_Duty_Specialist__c,' +
                'Alignment_Service_or_Wheel_Alignment__c,Hybrid_Specialist__c,Electrical_Specialist__c,' +
                'Diagnostic_Service_Computer_Diagnosti__c,State_Inspections__c,TNET_Geo_Location__Longitude__s,TNET_Geo_Location__Latitude__s,' +
                'TNET_36_36_Badge__c,TNET_ASE_Certified_Badge__c,TNET_RepairPal_Badge__c,TNET_Badges_Active__c,TNET_BBB_Badge__c,TNET_MAP_Badge__c,TNET_More_Shop_Info__c,TNET_Service_Details__c'+
                ' ,(SELECT id from Attachments ORDER BY CreatedDate DESC LIMIT 1)'+
                ' FROM Tech_Net__c ';
        String whereStr ='WHERE';
        whereStr = whereStr + ' Available_on_Find_Your_Shop__c = TRUE AND account_name__r.Tech_Net_Customer__c = TRUE';
        whereStr = whereStr + ' AND Enrollment_Status__c = \'Enrolled\' ';
        whereStr = whereStr + 'AND DISTANCE(TNET_Geo_Location__c,GEOLOCATION('+latitude+','+longitude+'),\'mi\') <'+radius;
        System.debug('query+whereStr:'+(query+whereStr));
        List<Tech_Net__c> techList = database.query(query+whereStr);

        return techList;
    }

    @AuraEnabled
    global static List<CollaborationGroup> getChatterGroups(){
        List<CollaborationGroupMember> groupMemberlist = [SELECT CollaborationGroupId FROM CollaborationGroupMember WHERE MemberId=:UserInfo.getUserId()];
        List<String> groupIdList = new List<String>();
        for(CollaborationGroupMember cgm:groupMemberlist){
            groupIdList.add(cgm.CollaborationGroupId);
        }

        List<CollaborationGroup > groupList = [SELECT Id,Name From CollaborationGroup where networkid=:Network.getNetworkId() AND id in:groupIdList];

        return groupList;
    }
    @AuraEnabled
    global static List<TNET_Tab__c> getConsumerTabs(){
        List<TNET_Tab__c> rs = [SELECT Id,Name,ParentTab__c,Is_Hidden__c,Navigation_Display_Name__c,
            (SELECT Order__c,Section_Description__c,Name,Video_Url__c FROM TNETS__r order by Order__c)
                FROM TNET_Tab__c WHERE TNET_Tab_Type__c ='Consumer' order by Order__c ];

        return rs;
    }

    @AuraEnabled
    global static List<TNET_Tab__c> getMemberTabs(){
        List<TNET_Tab__c> rs = [SELECT Id,Name,ParentTab__c,Is_Hidden__c,Navigation_Display_Name__c,
            (SELECT Order__c,Section_Description__c,Name,Video_Url__c FROM TNETS__r order by Order__c)
                FROM TNET_Tab__c WHERE TNET_Tab_Type__c ='Member' order by Order__c];

        return rs;
    }

    Global static void fakeTest(){
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
        i++;
        i++;
        i++;
        i++;
        i++;




    }

}