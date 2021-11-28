public with sharing class Utility {
@AuraEnabled(cacheable=true)
public static Map<String,Specialization__c> getSpecializations() {
    Map<String,Specialization__c> specializationList = new Map<String,Specialization__c>();
   for (Specialization__c spec : [SELECT Name,Price__c FROM Specialization__c ]){
    specializationList.put(spec.Name, spec);
   }
   return specializationList;
 }

 @AuraEnabled(cacheable=true)
public static List<Physician__c> getPhysiciansbySpecialization(String name) {
    List<Physician__c> physicianList = new List<Physician__c>();
   for (Physician__c physician : [SELECT Name,Email__c,Summary__c FROM Physician__c where Specialization__r.Name =:name and Summary__c != null
                                  and Summary__c != '']){
    physicianList.add(physician);
   }
   return physicianList;
 }
}
