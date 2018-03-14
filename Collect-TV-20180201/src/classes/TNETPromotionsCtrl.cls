public without sharing class TNETPromotionsCtrl {

    private static Date today = date.newinstance(System.today().year()-1,1,1);
    private static String selectString = 'SELECT Deadline__c, '
            + 'Start_Date__c, '
            + 'End_Date__c, '
            + 'Details__c, '
            + 'Name, '
            + 'Objectives__c, '
            + 'Requirements__c, '
            + 'Categories__c, '
            + 'Status__c ' //removed the comma
            //+ 'Segment__c, '
            //+ 'Big_Bets__c, '
            //+ 'Platforms__c, '
            //+ 'Tactics__c '
            //+ '(SELECT Status__c FROM Supplier_Requests__r WHERE Requested_By__c IN :myAccountUserIdSet)'
            + 'FROM TECHNET_Promotion__c ';
    private static String conditions = 'WHERE End_Date__c >= :today ';
    //+ 'AND RecordType.Name = \'Campaign\' '
    //+ 'AND Status__c = \'Approved\' ';
    private static String orderByString = ' ORDER BY Start_Date__c, End_Date__c';

    @AuraEnabled
    public static List<ProgramWrapper> getPrograms(){
        System.debug('<-------inside getPrograms()------->');
        String soql = selectString + conditions + orderByString;
        Set<Id> myAccountUserIdSet = TNETUtil.getMyAccountUsers();

        List<TECHNET_Promotion__c> programList = Database.query(soql);

        Map<Id, String> programIdImageMap = getProgramImages(programList);

        List<ProgramWrapper> programWrapperList = getProgramWrappers(programList, programIdImageMap);

        return programWrapperList;
    }




    private static Map<Id, String> getProgramImages(List<TECHNET_Promotion__c> programList){

        Set<Id> programIdSet = new Set<Id>();
        for (TECHNET_Promotion__c p : programList) {
            programIdSet.add(p.Id);
        }
        System.debug(LoggingLevel.INFO, '*** programIdSet: ' + programIdSet);

        Map<Id, String> programIdImageMap = new Map<Id, String>();
        for (Attachment a : [
                SELECT  Name,
                        ParentId
                FROM    Attachment
                WHERE   ParentId IN :programIdSet
                ORDER BY LastModifiedDate DESC]) {
            if (TNETUtil.isAvailableImage(a.Name)) {
                if (!programIdImageMap.containsKey(a.ParentId)) {
                    programIdImageMap.put(a.ParentId, Site.getBaseUrl() + '/servlet/servlet.FileDownload?file=' + a.Id);
                }
            }
        }
        System.debug(LoggingLevel.INFO, '*** programIdImageMap: ' + programIdImageMap);
        return programIdImageMap;
    }

    private static String getDefaultProgramImage(){
        String defaultProgramImage = '';
        for (Document d : [
                SELECT  Id
                FROM    Document
                WHERE   Name =  'logoHORZ-400x131.png'
                LIMIT 1]) {
            defaultProgramImage = Site.getBaseUrl() + '/servlet/servlet.ImageServer?id=' + d.Id + '&oid=' + UserInfo.getOrganizationId();
        }
        System.debug('defaultProgramImage -->'+defaultProgramImage);
        return defaultProgramImage;
    } //'Program Default Grid Image'

    private static List<ProgramWrapper> getProgramWrappers(List<TECHNET_Promotion__c> programList, Map<Id, String> programIdImageMap){
        List<ProgramWrapper> programWrapperList = new List<ProgramWrapper>();
        String defaultProgramImage = getDefaultProgramImage();
        for (TECHNET_Promotion__c p : programList) {
            // program image
            String image = programIdImageMap.get(p.Id);
            if (image == null) {
                image = defaultProgramImage;
            }

            // supplier request status
            Integer requested = 0;
            Integer underReview = 0;
            Integer enrolled = 0;
/*
            for (Supplier_Request__c sr : p.Supplier_Requests__r) {
                if(sr.Status__c == 'Requested') {
                    requested ++;
                }else if(sr.Status__c == 'Under Review') {
                    underReview ++;
                }else if(sr.Status__c == 'Enrolled') {
                    enrolled ++;
                }
            }
*/
            ProgramWrapper pw = new ProgramWrapper(p, image, requested, underReview, enrolled);
            programWrapperList.add(pw);
        }
        return programWrapperList;
    }

    public class FilterWrapper{
        @AuraEnabled
        public String filterField {get; set;}
        @AuraEnabled
        public List<String> filterValues {get; set;}
    }

    public class ProgramWrapper{
        @AuraEnabled
        public TECHNET_Promotion__c program {get; set;}
        @AuraEnabled
        public String programImage {get; set;}
        @AuraEnabled
        public List<String> segments {get; set;}
        @AuraEnabled
        public List<String> bigBets {get; set;}
        @AuraEnabled
        public Integer startYear {get; set;}
        @AuraEnabled
        public Integer startMonth {get; set;}
        @AuraEnabled
        public Integer startDay {get; set;}
        @AuraEnabled
        public Integer endYear {get; set;}
        @AuraEnabled
        public Integer endMonth {get; set;}
        @AuraEnabled
        public Integer endDay {get; set;}
        @AuraEnabled
        public Integer requested   {get; set;}
        @AuraEnabled
        public Integer underReview {get; set;}
        @AuraEnabled
        public Integer enrolled    {get; set;}

        public ProgramWrapper(TECHNET_Promotion__c program, String programImage, Integer requested, Integer underReview, Integer enrolled){
            this.program = program;
            this.programImage = programImage;
            if (program != null) {
                this.startYear = program.Start_Date__c == null ? 0 : program.Start_Date__c.year();
                this.startMonth = program.Start_Date__c == null ? 0 : program.Start_Date__c.month();
                this.startDay = program.Start_Date__c == null ? 0 : program.Start_Date__c.day();
                this.endYear = program.End_Date__c == null ? 0 : program.End_Date__c.year();
                this.endMonth = program.End_Date__c == null ? 0 : program.End_Date__c.month();
                this.endDay = program.End_Date__c == null ? 0 : program.End_Date__c.day();
/*
                if (String.isNotBlank(program.Segment__c)) {
                    segments = program.Segment__c.split(';');
                }

                if (String.isNotBlank(program.Big_Bets__c)) {
                    bigBets = program.Big_Bets__c.split(';');
                }
*/
            }
            this.requested = requested;
            this.underReview = underReview;
            this.enrolled = enrolled;
        }
    }
}