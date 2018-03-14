public with sharing class TNETBannerHeadingCtrl {

    @AuraEnabled
    public static List<BannerHeadingWrapper> getBannerHeadings() {
        Set<Id> bannerHeadingIdSet = new Set<Id>();
        List<TNET_Banner_Heading__c> bannerHeadingList = [
            SELECT  TNET_Title__c,
                    TNET_Heading_For_Banner__c,
                    TNET_Description__c,
            		TNET_URL__c,
                    TNET_Carousel_Image__c
            FROM    TNET_Banner_Heading__c
            WHERE   TNET_Is_Active__c = true
            AND     TNET_Type__c = 'TNET'
            ORDER BY TNET_Order__c ASC ];

        for (TNET_Banner_Heading__c bh : bannerHeadingList) {
            bannerHeadingIdSet.add(bh.Id);
        }
        System.debug(LoggingLevel.INFO, '*** bannerHeadingIdSet: ' + bannerHeadingIdSet);

        Map<Id, String> bannerHeadingIdImageMap = new Map<Id, String>();
        for (Attachment a : [
                SELECT  Name,
                        ParentId
                FROM    Attachment
                WHERE   ParentId IN :bannerHeadingIdSet
                ORDER BY LastModifiedDate DESC]) {
            if (TNETUtil.isAvailableImage(a.Name)) {
                if (!bannerHeadingIdImageMap.containsKey(a.ParentId)) {
                 //      !URLFOR($Action.Attachment.Download
                       bannerHeadingIdImageMap.put(a.ParentId, Site.getBaseUrl() + '/servlet/servlet.FileDownload?file=' + a.Id);
                 //      bannerHeadingIdImageMap.put(a.ParentId, Site.getBaseUrl() + '/servlet/servlet.FileDownload?file=' + a.Id);
                }
            }
        }
        System.debug(LoggingLevel.INFO, '*** bannerHeadingIdImageMap: ' + bannerHeadingIdImageMap);

        List<BannerHeadingWrapper> BannerHeadingWrapperList = new List<BannerHeadingWrapper>();
        for (TNET_Banner_Heading__c bh : bannerHeadingList) {
            String bannerImage = bannerHeadingIdImageMap.get(bh.Id);
           // String bannerImage = getResourceURL(bh.TNET_Carousel_Image__c);
            System.debug(LoggingLevel.INFO, '*** bannerImage: ' + bannerImage);
            if(bannerImage != null){
                BannerHeadingWrapper bhw = new BannerHeadingWrapper();
                bhw.bannerHeading = bh;
                bhw.bannerImage = bannerImage;
                BannerHeadingWrapperList.add(bhw);
            }
        }
        System.debug(LoggingLevel.INFO, '*** BannerHeadingWrapperList: ' + BannerHeadingWrapperList);
        return BannerHeadingWrapperList;
    }
    
        @AuraEnabled
    public static List<BannerHeadingWrapper> getPageBanners(String tabName) {//String tabName
        Set<Id> bannerHeadingIdSet = new Set<Id>();
        String tab = tabName.replace('-', ' ');
        List<TNET_Banner_Heading__c> bannerHeadingList = [
            SELECT  TNET_Title__c,
                    TNET_Banner_Title__c
            FROM    TNET_Banner_Heading__c
            WHERE   TNET_Is_Active__c = true
            AND     TNET_Type__c = 'TNET Page'
            AND		TNET_Title__c =:tab];

        for (TNET_Banner_Heading__c bh : bannerHeadingList) {
            bannerHeadingIdSet.add(bh.Id);
        }
        System.debug(LoggingLevel.INFO, '*** bannerHeadingIdSet: ' + bannerHeadingIdSet);

        Map<Id, String> bannerHeadingIdImageMap = new Map<Id, String>();
        for (Attachment a : [
                SELECT  Name,
                        ParentId
                FROM    Attachment
                WHERE   ParentId IN :bannerHeadingIdSet
                ORDER BY LastModifiedDate DESC]) {
            if (TNETUtil.isAvailableImage(a.Name)) {
                if (!bannerHeadingIdImageMap.containsKey(a.ParentId)) {
                 //      !URLFOR($Action.Attachment.Download
                       bannerHeadingIdImageMap.put(a.ParentId, Site.getBaseUrl() + '/servlet/servlet.FileDownload?file=' + a.Id);
                 //      bannerHeadingIdImageMap.put(a.ParentId, Site.getBaseUrl() + '/servlet/servlet.FileDownload?file=' + a.Id);
                }
            }
        }
        System.debug(LoggingLevel.INFO, '*** bannerHeadingIdImageMap: ' + bannerHeadingIdImageMap);

        List<BannerHeadingWrapper> BannerHeadingWrapperList = new List<BannerHeadingWrapper>();
        for (TNET_Banner_Heading__c bh : bannerHeadingList) {
            String bannerImage = bannerHeadingIdImageMap.get(bh.Id);
            System.debug(LoggingLevel.INFO, '*** bannerImage: ' + bannerImage);
            if(bannerImage != null){
                BannerHeadingWrapper bhw = new BannerHeadingWrapper();
                bhw.bannerHeading = bh;
                bhw.bannerImage = bannerImage;
                BannerHeadingWrapperList.add(bhw);
            }
        }
        System.debug(LoggingLevel.INFO, '*** BannerHeadingWrapperList: ' + BannerHeadingWrapperList);
        return BannerHeadingWrapperList;
    }
    @AuraEnabled
	public static List<BannerHeadingWrapper> getBannerHeadingsForTileCmp() {
        Set<Id> bannerHeadingIdSet = new Set<Id>();
        List<TNET_Banner_Heading__c> bannerHeadingList = [
                SELECT  TNET_Title__c,
                        TNET_Heading_For_Banner__c,
                        TNET_Description__c,
                        TNET_URL__c
                FROM    TNET_Banner_Heading__c
                WHERE   TNET_Is_Active__c = true
                AND     TNET_Type__c = 'TNET Tiles'
                ORDER BY TNET_Order__c ASC ];

        for (TNET_Banner_Heading__c bh : bannerHeadingList) {
            bannerHeadingIdSet.add(bh.Id);
        }
        System.debug(LoggingLevel.INFO, '*** bannerHeadingIdSet: ' + bannerHeadingIdSet);

        Map<Id, String> bannerHeadingIdImageMap = new Map<Id, String>();
        for (Attachment a : [
                SELECT  Name,
                        ParentId
                FROM    Attachment
                WHERE   ParentId IN :bannerHeadingIdSet
                ORDER BY LastModifiedDate DESC]) {
            if (TNETUtil.isAvailableImage(a.Name)) {
                if (!bannerHeadingIdImageMap.containsKey(a.ParentId)) {
                    //      !URLFOR($Action.Attachment.Download
                    bannerHeadingIdImageMap.put(a.ParentId, Site.getBaseUrl() + '/servlet/servlet.FileDownload?file=' + a.Id);
                    //      bannerHeadingIdImageMap.put(a.ParentId, Site.getBaseUrl() + '/servlet/servlet.FileDownload?file=' + a.Id);
                }
            }
        }
        System.debug(LoggingLevel.INFO, '*** bannerHeadingIdImageMap: ' + bannerHeadingIdImageMap);

        List<BannerHeadingWrapper> BannerHeadingWrapperList = new List<BannerHeadingWrapper>();
        for (TNET_Banner_Heading__c bh : bannerHeadingList) {
            String bannerImage = bannerHeadingIdImageMap.get(bh.Id);
            System.debug(LoggingLevel.INFO, '*** bannerImage: ' + bannerImage);
            if(bannerImage != null){
                BannerHeadingWrapper bhw = new BannerHeadingWrapper();
                bhw.bannerHeading = bh;
                bhw.bannerImage = bannerImage;
                BannerHeadingWrapperList.add(bhw);
            }
        }
        System.debug(LoggingLevel.INFO, '*** BannerHeadingWrapperList: ' + BannerHeadingWrapperList);
        return BannerHeadingWrapperList;
    }
    public class BannerHeadingWrapper {
        @AuraEnabled
        public TNET_Banner_Heading__c bannerHeading {get; set;}
        @AuraEnabled
        public String bannerImage {get; set;}
    }
/*
    public static String getResourceURL(String resourceName){
        List<StaticResource> resourceList= [SELECT Name, NamespacePrefix, SystemModStamp FROM StaticResource WHERE Name =:resourceName];
        if(resourceList.size() == 1){
            String namespace = resourceList[0].NamespacePrefix;
            return '/members/resource/' + resourceList[0].SystemModStamp.getTime() + '/' + resourceName;
        }
        else return '';
    } */
}