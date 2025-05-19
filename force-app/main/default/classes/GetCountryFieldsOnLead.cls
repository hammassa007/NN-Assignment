/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Apex class to get country fields on Lead Object.
 * @Date         : 05-20-2025
**/

public class GetCountryFieldsOnLead {
    public static void getCountryFields(List<Country__c> countryList) {
        try{
            List<Lead> leadToUpdate = new List<Lead>();
            Map<Id,Country__c> mapOfCountryIdVsCountry = new Map<Id,Country__c>();

            for (Country__c c : countryList) {
                mapOfCountryIdVsCountry.put(c.Id, c);
            }

            for (Lead l : [SELECT Id, Name, Country__c, Country_Alpha2Code__c, Country_Alpha3Code__c, Country_Capital__c, Country_Region__c 
                            FROM Lead 
                            WHERE Country__c IN :mapOfCountryIdVsCountry.keyset()]
                            ) {
                if(mapOfCountryIdVsCountry.containsKey(l.Country__c)){
                    l.Country__c = mapOfCountryIdVsCountry.get(l.Country__c).Id;
                    l.Country_Alpha2Code__c = mapOfCountryIdVsCountry.get(l.Country__c).Alpha2Code__c;
                    l.Country_Alpha3Code__c = mapOfCountryIdVsCountry.get(l.Country__c).Alpha3Code__c;
                    l.Country_Capital__c = mapOfCountryIdVsCountry.get(l.Country__c).Capital_City__c;
                    l.Country_Region__c = mapOfCountryIdVsCountry.get(l.Country__c).Region__c;
                    leadToUpdate.add(l);
                }
            }
            if(!leadToUpdate.isEmpty()){
                update leadToUpdate;
            }
        }catch(Exception e){
            //log exception
            System.debug('=== Error updating leads ==='+e.getMessage());
        }
    }
}