/**
 * Created by yshao009 on 4/25/17.
 */

global class TNETGeoAddressBatch implements Database.batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    global List<String> sObjectLst;
    global Boolean isFullRun;
    global Integer index;
    global String LastRunId;
    global Integer successCount = 0;
    global Integer failedCount = 0;
    global Integer existedCount = 0;

    global TNETGeoAddressBatch(String sobjName){
        this(sobjName,false);
    }

    global TNETGeoAddressBatch(String sobjName, Boolean fullrun){
        this(new List<String>{sobjName}, fullrun);
    }

    global TNETGeoAddressBatch(List<String> sobjLst) {
        this(sobjLst, false,0);
    }

    global TNETGeoAddressBatch(List<String> sobjLst, Boolean fullrun) {
        this(sobjLst,fullrun,0);
    }

    global TNETGeoAddressBatch(List<String> sobjLst, Boolean fullrun, Integer num) {
        sObjectLst = sobjLst;
        isFullRun = fullrun;
        index = num;
    }

    global Database.Querylocator start(Database.BatchableContext bc){
        Type geoAddressType = Type.forName(TNETGeoAddressUtil.OBJECT_PREFIX + sObjectLst[index]);
        TNETIGeoAddress ga = (TNETIGeoAddress)geoAddressType.newInstance();
        String queryWhere = '';
//        Common_Setting__c setting = Common_Setting__c.getInstance('GeoGoogle'+sObjectLst[index]);
//        if(setting != null) {
//            if(String.isNotEmpty(setting.Value__c)) {
//                queryWhere = ' where Id > \'' +setting.Value__c + '\'';
//            }
//        }
        if(Test.isRunningTest()){
            queryWhere = ' WHERE Website_Primary_Phone__c = \'123\'';
        }else{
            queryWhere = ' WHERE Available_on_Find_Your_Shop__c = TRUE ';
            queryWhere = queryWhere + ' AND Enrollment_Status__c = \'Enrolled\' ';
        }
        String sql = 'select Id'
                + ' from ' + ga.getAPIName()
                + queryWhere;
        System.debug('****sql****:'+sql);
        return Database.getQueryLocator(sql);
    }

    global void execute(Database.BatchableContext bc, List<sObject> sobjs){
        //the batch size is supposed to set as 1 to avoid any call out limit and increase time span between callouts
        List<Sobject> objLst = new List<Sobject>();
        for(Sobject  obj : sobjs) {
            String status = TNETGeoAddressUtil.geoMultipleSobject(sObjectLst[index], obj.Id,objLst);
            if(status == 'OK'){
                LastRunId = obj.Id;
                successCount++;
            }else if(status == 'Existed'){
                existedCount++;
            }else {
                failedCount++;
            }
        }

        update objLst;
        //upsert monitorLst Geo_Address__c;
//        Common_Setting__c setting = Common_Setting__c.getInstance('GeoGoogle'+sObjectLst[index]);
//        if(setting != null && String.isNotEmpty(LastRunId)) {
//            setting.Value__c = LastRunId;
//            update setting;
//        }
    }

    global void finish(Database.BatchableContext bc){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSaveAsActivity(false);
        mail.setSubject('Geo Job for '+sObjectLst[index]+' is finished');

        String content = '';
        content += '<p>Success: ' + successCount +  '</p>';
        content += '<p>Failed: ' + failedCount + '</p>';
        content += '<p>Existed: ' + existedCount + '</p>';
        content += '<br/>';

        mail.setHtmlBody(content);
        mail.setToAddresses(new List<String>{UserInfo.getUserEmail()});
        mail.setBccSender(false);
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});

        index++;
        if(index < sObjectLst.size()) {
            TNETGeoAddressBatch job = new TNETGeoAddressBatch(sObjectLst,isFullRun,index);
            Database.executeBatch(job,20);
        }
    }
}