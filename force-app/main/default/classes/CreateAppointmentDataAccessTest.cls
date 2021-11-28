@isTest
private class CreateAppointmentDataAccessTest {
    @isTest
    private static void saveAppointmentTest() {
        Specialization__c spec = new Specialization__c();
        spec.Name = 'Cardiology';
        insert spec;
        Physician__c physician = new Physician__c();
        physician.Specialization__c = spec.Id;
        physician.Summary__c = 'Test';
        insert physician;
        CreateAppointmentDataAccess.saveAppointment(Datetime.newInstance(2021, 11, 30, 11, 0, 0),'Test','test@gmail.com');
        List<Appointment__c> appt = [Select Id,Appointment_Date_and_Time__c, Patient_Email__c from Appointment__c];
        System.assert(appt != null);
        System.assertEquals(Datetime.newInstance(2021, 11, 30, 11, 0, 0), appt[0].Appointment_Date_and_Time__c);
        System.assertEquals('test@gmail.com', appt[0].Patient_Email__c);
    }
}