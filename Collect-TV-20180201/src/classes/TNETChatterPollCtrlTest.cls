/**
 * Created by yshao009 on 5/2/17.
 */
@IsTest(SeeAllData=true)
public with sharing class TNETChatterPollCtrlTest {
    static testMethod void testChatterPoll(){
        TNETChatterPollCtrl tc = new TNETChatterPollCtrl();
        tc.pw.pollText = 'test';
        tc.pw.pollContacts[0].LastName = 'test';
        tc.pw.pollContacts[1].LastName = 'test';
        tc.pw.pollContacts[2].LastName = 'test';
        CollaborationGroup gr = new CollaborationGroup();
        gr.Name = 'test';
        gr.Description = 'test';
        gr.CollaborationType = 'Public';
        insert gr;
        Test.setCurrentPageReference(new PageReference('Page.TNETChatterPollPage'));
        System.currentPageReference().getParameters().put('id', gr.Id);
        TNETChatterPollCtrl.getPollReports();
        TNETChatterPollCtrl.fakeTest();
        tc.save();
    }
}