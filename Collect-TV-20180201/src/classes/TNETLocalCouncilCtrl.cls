/**
 * Created by yshao009 on 5/22/17.
 */

public  without sharing class TNETLocalCouncilCtrl {
    @AuraEnabled
    public static initInfo getInitData(){
        InitInfo initInfo = new InitInfo();
        initInfo.titles = TNETUtil.getPicklistValues('Local_Council_Form__c','Title_of_Individual_Submitting_Request__c').values();
        initInfo.recordTypeList = getRecordTypeStringList('Local_Council_Form__c');
        initInfo.currentUserName = UserInfo.getName();
        initInfo.currentDate = System.today();
        return initInfo;
    }

    @AuraEnabled
    public static String insertForm(Local_Council_Form__c localForm){
        String rs = 'Success';
        try{
            List<Local_Council_Form__c> duplicateNameFormList = [SELECT id FROM Local_Council_Form__c WHERE Group_Name__c =:localForm.Group_Name__c];
            List<CollaborationGroup> duplicateNameGroupList = [SELECT id FROM CollaborationGroup WHERE Name =:localForm.Group_Name__c];
            if(duplicateNameFormList.size()>0||duplicateNameGroupList.size()>0){
                return 'This Group Name is already taken';
            }
            insert localForm;
            Approval.ProcessSubmitRequest req1 =
                    new Approval.ProcessSubmitRequest();
            req1.setComments('');
            req1.setObjectId(localForm.id);
            // Submit the approval request for the account
            Approval.ProcessResult result = Approval.process(req1);
        }catch (Exception e){
            rs = e.getMessage();
        }
        return rs;

    }
    public class InitInfo {
        @AuraEnabled
        List<String> titles {get;set;}

        @AuraEnabled
        List<RecordTypeOption> recordTypeList{get;set;}

        @AuraEnabled
        String currentUserName {get;set;}

        @AuraEnabled
        Date currentDate {get;set;}
    }

    @InvocableMethod(label='create a chatter group')
    public static void DeleteRecord(list<string> recordIds ) {
        System.debug('****Id****'+recordIds);
        CollaborationGroup gr = new CollaborationGroup();
        Local_Council_Form__c form = [SELECT ID,createdbyid,Group_Name__c,Group_Description__c FROM Local_Council_Form__c WHERE ID = :recordIds[0]];
        gr.Name = form.Group_Name__c;
        gr.Description = form.Group_Description__c;
        gr.OwnerId = UserInfo.getUserId();
        gr.CollaborationType = 'Private';
        List<Network> techList = [SELECT id, name FROM Network where Name=:Label.TNET_Site_Name];//'Technet Dev'
        gr.NetworkId = techList[0].Id;
        insert gr;
        List<Group> quenes = [select Id from Group where name='TNETChatterGroupApprover'];
        if(quenes.size() == 0){
            throw new MyException('No Queue found');
        }
        List<CollaborationGroupMember> alreadyExistMember = [SELECT MemberId FROM CollaborationGroupMember WHERE CollaborationGroupId=:gr.ID ];
        String alreadyExistMemberId = '';
        if(alreadyExistMember.size()>0){
            alreadyExistMemberId = alreadyExistMember[0].MemberId;
        }
        List<GroupMember> queueMembers = [select UserOrGroupId from GroupMember where GroupId =: quenes[0].Id];
        List<CollaborationGroupMember> cGroupList = new List<CollaborationGroupMember>();

        CollaborationGroupMember member = new CollaborationGroupMember();
        member.CollaborationGroupId = gr.Id;
        member.MemberId = form.createdbyid;
        member.CollaborationRole = 'Admin';
        if(form.createdbyid != alreadyExistMemberId){
            cGroupList.add(member);
        }

        //insert member;
        System.debug('****alreadyExistMemberId****' + alreadyExistMemberId);
        System.debug('****form.createdbyid****' + form.createdbyid);
        System.debug('****queueMembers****' + queueMembers);
        for(GroupMember gm :queueMembers){
            if(gm.UserOrGroupId == alreadyExistMemberId || gm.UserOrGroupId == form.createdbyid){
                continue;
            }
            CollaborationGroupMember mb = new CollaborationGroupMember();
            mb.CollaborationGroupId = gr.Id;
            mb.MemberId = gm.UserOrGroupId;
            cGroupList.add(mb);

        }
        insert cGroupList;

    }
    public class RecordTypeOption{
        @AuraEnabled
        String name {get;set;}
        @AuraEnabled
        String id {get;set;}
    }


    private static List<RecordTypeOption> getRecordTypeStringList(String obj){
        Schema.DescribeSobjectResult  dsr = Schema.getGlobalDescribe().get(obj).getDescribe();
        List<Schema.RecordTypeInfo> rt = dsr.getRecordTypeInfos();
        List<RecordTypeOption> rtStrList = new List<RecordTypeOption>();
        for(Schema.RecordTypeInfo rti:rt){
            if(!rti.isMaster()){
                RecordTypeOption rto = new RecordTypeOption();
                rto.name = rti.getName();
                rto.id = rti.getRecordTypeId();

                rtStrList.add(rto);
            }

        }
        return rtStrList;

    }
    class MyException extends Exception{}

}