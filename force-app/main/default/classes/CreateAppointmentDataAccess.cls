public with sharing class CreateAppointmentDataAccess {
    public static void saveAppointment(Datetime apptTime, String summary, String email) {
        Appointment__c appt = new Appointment__c();
        appt.Appointment_Date_and_Time__c = apptTime;
        appt.Patient_Email__c = email;
        List<Physician__c> physician = [Select Id,Specialization__c from Physician__c where summary__c = : summary];
        if (physician[0] != null){
            appt.Physician__c = physician[0].Id;
            insert appt;
        }

    }
}
