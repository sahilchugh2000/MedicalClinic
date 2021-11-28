public with sharing class CalenderActivitiesController {

@AuraEnabled(cacheable=true)
public static Map<String,String> getCalenderList() {
   Map<String,String> calenderMap = new Map<String,String>();
   GoogleCalenderService service = new GoogleCalenderService();
   GoogleCalenderService.CalendarListResponse response = service.getMyCalendar();
   if (response != null){
     for (GoogleCalendarList cal :  response.items){
      calenderMap.put(cal.summary,cal.id);
     }
     return calenderMap;
   }
   else{
     return null;
   }

 }

 @AuraEnabled(cacheable=false)
public static void createCalenderEvent(String email, Datetime apptTime, String calenderId, String summary) {
  System.debug('Hey ' + email + apptTime + CalenderId);
  GoogleCalenderService service = new GoogleCalenderService();
  GoogleCalendarEvent event = new GoogleCalendarEvent();
  event.summary = 'Physician Appointment';
  event.setDateAndDuration(apptTime, 10);
  event.addAttendee(email);
  service.insertEvent(calenderId, event);
  CreateAppointmentDataAccess.saveAppointment(apptTime, summary, email);
 }

}
