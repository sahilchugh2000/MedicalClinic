public with sharing class GoogleCalenderService {

    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
 	public static final String GET_CALENDAR_LIST_URL = 'callout:GoogleAPI/calendar/v3/users/me/calendarList';
    public static final String CALENDAR_URL = 'callout:GoogleAPI/calendar/v3';

    public CalendarListResponse getMyCalendar() {

        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint(GET_CALENDAR_LIST_URL);
        SetAuthenticationHeader(request);
        response = http.send(request);
		System.debug('listCalendarList: ' + response.getBody());
		return ((CalendarListResponse)System.JSON.deserialize(response.getBody(), CalendarListResponse.class));
    }

    public void insertEvent(String calenderId, GoogleCalendarEvent event) {
		String url = CALENDAR_URL + '/calendars/' + EncodingUtil.urlEncode(calenderId, 'utf-8') + '/events';
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(url);
        SetAuthenticationHeader(request);
        System.debug('eventinput: ' + event.toString());
        request.setBody(event.toString());
        response = http.send(request);
	}

    private void SetAuthenticationHeader(HttpRequest request){
		GoogleCalenderAPI__c setting = GoogleCalenderAPI__c.getInstance();
		String username = setting.Customer_Key__c;
        String password = setting.Customer_Secret__c;
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'BASIC ' +
        EncodingUtil.base64Encode(headerValue);
        request.setHeader('Authorization', authorizationHeader);
    }

    	public class CalendarListResponse {
		public String kind { get; set;}
		public String etag { get; set;}
        public String nextSyncToken { get; set;}
		public List<GoogleCalendarList> items { get; set;}
	}
}