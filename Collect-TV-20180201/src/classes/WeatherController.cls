public class WeatherController {

    static String baseURL = 'http://api.wunderground.com/api/';

    // Sign up for an API key here: http://www.wunderground.com/weather/api/d/login.html
	static String apiKey = '7e0c724720e38ebf';

    @AuraEnabled
    public static String getWeather(String q) {

        String url = baseURL + apiKey + '/conditions/forecast/q/' + q + '.json';
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('GET');
        req.setEndpoint(url);
		try {
            HTTPResponse res = http.send(req);
			return res.getBody();
        } catch(Exception ex){
            return '{"error": "' + ex.getMessage() + '"}';
        }

    }
}