@istest
private with sharing class CalenderActivitiesControllerTest {
    @istest
    private static void getCalenderListTest() {
        Map<String,String> calenderMap = new Map<String,String>();
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('CalenderList');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);        
        calenderMap = CalenderActivitiesController.getCalenderList();
        System.assert(calenderMap!=null);
        System.assertEquals(6, calenderMap.keyset().size());
    }
    
    @istest
    private static void createCalenderEventTest() {
        Specialization__c spec = new Specialization__c();
        spec.Name = 'Cardiology';
        insert spec;
        Physician__c physician = new Physician__c();
        physician.Specialization__c = spec.Id;
        physician.Summary__c = 'Test';
        insert physician;
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('CalenderList');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
		Test.startTest();        
        CalenderActivitiesController.createCalenderEvent('test@gmail.com', Datetime.newInstance(2021, 11, 30, 11, 0, 0), 
                                                         'https://calendar.google.com/calendar/embed?src=6t143o88eb15ga56rmg2eqha00@group.calendar.google.com', physician.Summary__c);
        Test.stopTest();
        List<Appointment__c> appt = [Select Id,Appointment_Date_and_Time__c, Patient_Email__c from Appointment__c];
        System.assert(appt != null);
        System.assertEquals(Datetime.newInstance(2021, 11, 30, 11, 0, 0), appt[0].Appointment_Date_and_Time__c);
        System.assertEquals('test@gmail.com', appt[0].Patient_Email__c);
    }
}