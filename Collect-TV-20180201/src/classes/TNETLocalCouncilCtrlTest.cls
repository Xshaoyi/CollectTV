/**
 * Created by yshao009 on 6/28/17.
 */
@IsTest
public with sharing class TNETLocalCouncilCtrlTest {
    static testMethod void testLocalCouncil(){
        TNETLocalCouncilCtrl.getInitData();
        Local_Council_Form__c lcf = new Local_Council_Form__c();
        lcf.Group_Name__c = 'test';
        TNETLocalCouncilCtrl.insertForm(lcf);
        List<String> idList = new List<String>();
        idList.add(lcf.Id);
        TNETLocalCouncilCtrl.DeleteRecord(idList);
    }
}