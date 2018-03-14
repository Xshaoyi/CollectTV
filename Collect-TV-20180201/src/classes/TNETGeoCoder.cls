/**
 * Created by yshao009 on 4/25/17.
 */

public without sharing class TNETGeoCoder {
    private static final String googleMapsAPI = 'https://maps.googleapis.com';
    private static final String googleGeocodeService = '/maps/api/geocode/';

    public static String googleOutput = 'json';//or xml
    public static String googleVersion = '3';
    public static String googleChannel = 'Resale';

    public static Boolean useEnterpriseLicense = true;
    public static String googleEnterpriseKey = Label.TNET_Google_Api_Key;
    public static String googleClientId = '';

    public static GeocodeResult geoCodeAddress(String street, String city, String state, String zipCode){
        String address = '';
        address += (street == null ? '' : street) + ',';
        address += (city == null ? '' : city) + ',';
        address += (state == null ? '' : state) + ',';
        address += (zipCode == null ? '' : zipCode);

        if(!String.isEmpty(address)){
            return geoCodeAddress(address);
        }else{
            return null;
        }
    }

    public static GeocodeResult geoCodeAddress(String address){
        try {
            if(Test.isRunningTest()){
                getGeocodeURL('forTest');
                return parseResponse('{"results":[{"geometry":{"location" : {"lat" : 37.4223895,"lng" : -122.0843123}}}],"status" : "OK"}');
            }
            HttpRequest req = new HttpRequest();
            req.setEndpoint(getGeocodeURL(EncodingUtil.urlEncode(address, 'UTF-8')));
            req.setMethod('GET');
            Http http = new Http();

            HTTPResponse res = http.send(req);
            return parseResponse(res.getBody());
        }catch (Exception e){
            //to do: implement error handler
            throw e;
        }
    }

    private static String getGeocodeURL(String address){
        String returnURL = '';
        if (useEnterpriseLicense){
            // returnURL = googleGeocodeService + googleOutput + '?' + 'client=' + googleClientId +'&sensor=false' + '&channel=' + googleChannel + '&address=' + address;
            // returnURL = googleMapsAPI + returnURL + '&signature=' + googleEnterpriseKey;

            returnURL = googleMapsAPI + googleGeocodeService + 'json?key=' + googleEnterpriseKey+ '&address=' + address + '&sensor=false';
        }else {
            returnURL = googleMapsAPI + googleGeocodeService + '?address=' + Address + '&sensor=false';
        }
        System.debug('******Google Map URL ' + returnURL);
        return returnURL;
    }


    private static GeocodeResult parseResponse(String responseBody){
        GeocodeResult result = new GeocodeResult();
        JSONParser parser = JSON.createParser(responseBody);
        while (parser.nextToken() != null){
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'location')){
                parser.nextToken();
                while (parser.nextToken() != JSONToken.END_OBJECT){
                    String txt = parser.getText();
                    parser.nextToken();
                    if(txt == 'lat'){
                        result.addressLat = parser.getText();
                    }else if (txt == 'lng'){
                        result.addressLng = parser.getText();
                    }
                }
            }

            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'status')){
                parser.nextToken();
                result.status = parser.getText();
            }
        }
        return result;
    }

    public class GeocodeResult {
        public String status;
        public String addressType;
        public String addressStreetNumber;
        public String addressRoute;
        public String addressLocality;
        public String addressPostalCode;
        public String addressCountry;
        public String addressLat;   //latitude
        public String addressLng;   //longitude
        public String exactMatch;

        public Boolean isSuccess(){
            return status == 'OK';
        }

        public decimal getLatValue(){
            return addressLat == null? null : decimal.valueOf(addressLat);
        }

        public decimal getLngValue(){
            return addressLng == null? null : decimal.valueOf(addressLng);
        }
    }
}