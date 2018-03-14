/**
 * Created by sankur001 on 4/3/2017.
 */

public with sharing class TNETProfileMenuCtrl {
    public static String TNETAdminPermiSet = 'TECH_NET_Community_Admin';
    @AuraEnabled
    public static UserWrapper getUserInfo()
    {
        UserWrapper userInfos = new UserWrapper();
        User usr = [SELECT Name,SmallPhotoUrl,profile.name,Email from User WHERE Id=:UserInfo.getUserId()]; //'0054D000000Qjd2'
        List<PermissionSetAssignment> psaList  = [select PermissionSet.Name from PermissionSetAssignment where Assignee.Id =:UserInfo.getUserId() and PermissionSet.Name=:TNETAdminPermiSet];
        userInfos.user = usr;
        List<TNET_Profile_Menu__c> menuAllList = [select id,name,order__c,path__c from TNET_Profile_Menu__c order by order__c];
        List<TNET_Profile_Menu__c> menuList = new List<TNET_Profile_Menu__c>();
        for(TNET_Profile_Menu__c menu : menuAllList){
            if(menu.name == 'Chatter Poll Report'){
                if(psaList.size()>0){
                    menuList.add(menu);
                }

            }else if(menu.name == 'Local Council Form'){
                if(usr.profile.name != 'TECHNET Community User'){
                    menuList.add(menu);
                }
            }else{
                menuList.add(menu);
            }
            if(menu.name == 'Chatter Groups'){
                menu.path__c = menu.path__c.replace('{id}',Label.TNET_Chatter_Group_filter_ID);
            }
        }

        userInfos.menuList = menuList;
        return userInfos;
    }

    public class UserWrapper{
        @AuraEnabled
        User user{get;set;}
        @AuraEnabled
        List<TNET_Profile_Menu__c> menuList{get;set;}
    }
}