/**
 * Created by yshao009 on 4/25/17.
 */

global class TNETGeoAddressUtil {
    global static String OBJECT_PREFIX = 'TNETGeo';
    

    global static String geoMultipleSobject(String sobjectName, Id sobjectId,List<Sobject> objLst){
        Type t = Type.forName(OBJECT_PREFIX + sobjectName);
        TNETIGeoAddress ga = (TNETIGeoAddress)t.newInstance();

        SObject sobj = fetchSingleSObject(sobjectName, sobjectId);

        if(sobj != null && (sobj.get(ga.getLongitudeField()) == null || sobj.get(ga.getLatitudeField()) == null) && sobj.get(ga.getPostalCodeField()) != null){
            ga.setSObject(sobj);
            TNETGeoCoder.GeocodeResult result = TNETGeoCoder.geoCodeAddress(ga.getGeoAddress());
            System.debug('***********' + result);
            if(result.isSuccess()){
                try{
                    sobj.put(ga.getLongitudeField(), result.getLngValue());
                    sobj.put(ga.getLatitudeField(), result.getLatValue());
                    sobj.put(ga.getCallStatusField(), '');
                    objLst.add(sobj);
                } catch(Exception ex) {
                    result.status = ex.getMessage();
                }
            } else if(result.status == 'ZERO_RESULTS') {
                sobj.put(ga.getCallStatusField(), 'Invalid Address');
                objLst.add(sobj);
            } else {
                sobj.put(ga.getCallStatusField(), result.status);
                objLst.add(sobj);
            }

            return result.Status;
        } else {
            return 'Existed';
        }

        return null;
    }

    public static SObject fetchSingleSObject(String sobjectName, String sobjectId){
        String sql = getQueryString(sobjectName);
        sql = sql + ' where Id = \'' + sobjectId + '\'';
        if(sobjectName.equalsIgnoreCase('Lead')) {//Close lead can not updated
            sql = sql + ' and IsConverted = false ';
        }
        List<SObject> sobjs = Database.query(sql);
        if(sobjs.size() > 0){
            return sobjs[0];
        }else{
            return null;
        }
    }

    public static String getQueryString(String sobjectName){
        Type t = Type.forName(OBJECT_PREFIX + sobjectName);
        TNETIGeoAddress ga = (TNETIGeoAddress)t.newInstance();

        String sql = 'select Id, Name'
                + ',' + ga.getLongitudeField()
                + ',' + ga.getLatitudeField() + ','
                + ga.getStreetField() + ','
                + ga.getCityField() + ','
                + ga.getStateField() + ','
                + ga.getPostalCodeField()
                + ' from ' + ga.getAPIName();

        return sql;
    }
}