/**
 * Created by yshao009 on 4/25/17.
 */

public with sharing class TNETGeoTechNet implements TNETIGeoAddress{
    private Tech_Net__c techShop;

    public TNETGeoTechNet() {

    }

    public void setSObject(SObject sobj){
        techShop = (Tech_Net__c)sobj;
    }

    public String getDisplayName() {
        return String.valueOf(this).substring(0,String.valueOf(this).indexOf(':')).replace(TNETGeoAddressUtil.OBJECT_PREFIX,'');
    }

    public String getAPIName() {
        return 'Tech_Net__c';
    }

    public String getLongitudeField(){
        return 'TNET_Geo_Location__Longitude__s';
    }

    public String getLatitudeField(){
        return 'TNET_Geo_Location__Latitude__s';
    }

    public String getStreetField(){
        return 'Website_Street__c';
    }

    public String getCityField(){
        return 'Website_City__c';
    }

    public String getStateField(){
        return 'Website_State_Province__c';
    }

    public String getPostalCodeField(){
        return 'Website_Zip_Postal_Code__c';
    }

    public String getCallStatusField(){
        return 'TNET_Geo_Call_Status__c';
    }

    public String getGeoAddress(){
        String address = '';

        if(techShop != null){
            address += (techShop.Website_Street__c == null ? '' : techShop.Website_Street__c) + ',';
            address += (techShop.Website_City__c == null ? '' : techShop.Website_City__c) + ',';
            address += (techShop.Website_State_Province__c == null ? '' : techShop.Website_State_Province__c) + ',';
            address += (techShop.Website_Zip_Postal_Code__c == null ? '' : techShop.Website_Zip_Postal_Code__c);
        }

        return address;
    }
}