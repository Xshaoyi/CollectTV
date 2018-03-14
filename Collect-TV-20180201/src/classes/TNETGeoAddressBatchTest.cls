/**
 * Created by yshao009 on 5/2/17.
 */
@IsTest(SeeAllData = true)
public with sharing class TNETGeoAddressBatchTest {
    static testMethod void testBatch(){
        List<Tech_Net__c> rsList = TNET_TestUtil.testGeoBatch();
        Test.startTest();

        TNETGeoAddressBatch t = new TNETGeoAddressBatch('TechNet');
        Database.executeBatch(t, 10);
        t.execute(null,rsList);
        TNETGeoCoder.geoCodeAddress('test','test','test','test');
        Test.stopTest();
    }

    static testMethod void testBatchScheduler(){
        TNETGeoAddressBatchScheduler m = new TNETGeoAddressBatchScheduler();
        String sch = '20 30 8 10 2 ?';
        String jobID = system.schedule('Merge Job', sch, m);
    }
}