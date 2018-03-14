/**
 * Created by yshao009 on 4/25/17.
 */

public interface TNETIGeoAddress{
    String getStreetField();
    String getCityField();
    String getStateField();
    String getPostalCodeField();
    String getLongitudeField();
    String getLatitudeField();
    String getCallStatusField();
    String getGeoAddress();
    String getDisplayName();
    String getAPIName();
    void setSObject(SObject sobj);
}