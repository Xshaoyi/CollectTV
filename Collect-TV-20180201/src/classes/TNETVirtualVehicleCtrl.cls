public without sharing class TNETVirtualVehicleCtrl {
    
    @AuraEnabled
    public static List<BannerHeadingWrapper> getBannerHeadings(String type) {
        Set<Id> bannerHeadingIdSet = new Set<Id>();
        List<TNET_Banner_Heading__c> bannerHeadingList = [
            SELECT  TNET_Title__c,
            TNET_Heading_For_Banner__c,
            TNET_Image_URL__c,
            TNET_Video_URL__c
            FROM    TNET_Banner_Heading__c
            WHERE   TNET_Is_Active__c = true
            AND     TNET_Type__c =:type
            ORDER BY TNET_Order__c ASC];//'Virtual Vehicle'
        
        for (TNET_Banner_Heading__c bh : bannerHeadingList) {
            bannerHeadingIdSet.add(bh.Id);
        }
        System.debug(LoggingLevel.INFO, '*** bannerHeadingIdSet: ' + bannerHeadingIdSet);
        
        Map<Id, String> bannerHeadingIdImageMap = new Map<Id, String>();
        for (TNET_Banner_Heading__c a : bannerHeadingList) {
            //     if (TNETUtil.isAvailableImage(a.Name)) {
            //         if (!bannerHeadingIdImageMap.containsKey(a.ParentId)) {
            bannerHeadingIdImageMap.put(a.Id, a.TNET_Image_URL__c);
            // }
            //  }
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
                if(bh.TNET_Video_URL__c !=null) bhw.bannerVideo = bh.TNET_Video_URL__c;
                BannerHeadingWrapperList.add(bhw);
            }
        }
        System.debug(LoggingLevel.INFO, '*** BannerHeadingWrapperList: ' + BannerHeadingWrapperList);
        return BannerHeadingWrapperList;
    }
    
  /*  @AuraEnabled
    public static String getVideoURL(String bannerImage) {
        List<BannerHeadingWrapper> BannerHeadingWrapperList = getBannerHeadings();
        String videoURL =null;
        for (BannerHeadingWrapper bh : BannerHeadingWrapperList) {
            System.debug(LoggingLevel.INFO, '*** bannerImage: ' + bannerImage);
            if(bannerImage != null && bh.bannerImage == bannerImage)
            {
                videoURL = bh.bannerVideo;
            }      
        }
        return videoURL;
    } */
    
    public class BannerHeadingWrapper {
        @AuraEnabled
        public TNET_Banner_Heading__c bannerHeading {get; set;}
        @AuraEnabled
        public String bannerImage {get; set;}
        @AuraEnabled
        public String bannerVideo {get; set;}
    }
}