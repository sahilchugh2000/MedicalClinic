@isTest
private class UtilityTest {
	
    	@testSetup()
        public static void setupData(){
        Specialization__c spec = new Specialization__c();
        spec.Name = 'Cardiology';
        insert spec;
        Specialization__c spec1 = new Specialization__c();
        spec1.Name = 'GP';
        insert spec1;
        Physician__c physician = new Physician__c();
        physician.Specialization__c = spec.Id;
        physician.Summary__c = 'Test';
        insert physician;
        
    }
    
    @isTest
    public static void getSpecializationsTest() {
        Map<String,Specialization__c> specializationMap = new Map<String,Specialization__c>();
        specializationMap = Utility.getSpecializations();
        System.assertEquals(2, specializationMap.keyset().size());
		System.assert(specializationMap!=null);
    }
    
    @isTest
    public static void getPhysiciansbySpecializationTest() {
        List<Physician__c> physicianList = new List<Physician__c>();
        physicianList = Utility.getPhysiciansbySpecialization('Cardiology');
        System.assertEquals(1, physicianList.size());
    }
}