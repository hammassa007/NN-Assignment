/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Apex class to make a Callout to Country Layer API
 *               : and syn country data in Salesforce with Country object.
 * @Date         : 06-06-2025
**/

public without sharing class FetchCountryInformation {
    
    @future(callout=true)
    public static void fetchAndSyncCountryInfo() {
        try{
            String endpoint = 'callout:Country_Layer_API';
            HttpRequest req = new HttpRequest();
            UtilityCallOut.setRequest(req, 'GET', endpoint);
            HTTPResponse resp = UtilityCallOut.sendRequest(req);

            if(resp.getStatusCode() == 200){
                List<Country__c> countryList = new List<Country__c>();
                Map<String, Country__c> mapOfExistingCountryNameVsCountry = new Map<String, Country__c>();
                for(Country__c c:[SELECT Id, Name, Alpha2Code__c, Alpha3Code__c, Capital_City__c, Region__c FROM Country__c]){
                    mapOfExistingCountryNameVsCountry.put(c.Name, c);
                }
                for(CountryApiParser parsedObj:CountryApiParser.parse(resp.getBody())){
                    if(!mapOfExistingCountryNameVsCountry.containsKey(parsedObj.name)){
                        countryList.add(createUpdateCountryRecord(parsedObj, null, true));//new country
                    }
                    else{
                        Country__c cl = mapOfExistingCountryNameVsCountry.get(parsedObj.name);
                        if(checkCountryFields(cl, parsedObj)){
                            countryList.add(createUpdateCountryRecord(parsedObj, cl.Id, false));
                        }                        
                    }
                }
                if(!countryList.isEmpty()){
                    upsert countryList;
                }
            }
            else {
                //handle error response
                //log transaction details
            }
        }catch(Exception ex){
            //log exception
            ExceptionLogger.logException(ex,'FetchCountryInformation','fetchAndSyncCountryInfo', 'Apex');
            System.debug('Error fetching countries: '+ex.getMessage());
        }
    }

    public static Boolean checkCountryFields(Country__c cl, CountryApiParser parsedObj){
        if(cl.Name <> parsedObj.name || 
            cl.Alpha2Code__c<>parsedObj.alpha2Code || 
            cl.Alpha3Code__c<>parsedObj.alpha3Code || 
            cl.Capital_City__c<>parsedObj.capital || 
            cl.Region__c<>parsedObj.region )
            {
                return true;
        }
        return false;
    }
    public static Country__c createUpdateCountryRecord(CountryApiParser parsedObj, string clId, boolean isNew){
        Country__c cl = new Country__c();
        if(!isNew) 
            cl.Id = clId;
            cl.Name = parsedObj.name;
            cl.Alpha2Code__c = parsedObj.alpha2Code;
            cl.Alpha3Code__c = parsedObj.alpha3Code;
            cl.Capital_City__c = parsedObj.capital;
            cl.Region__c = parsedObj.region;
            return cl;
    } 
}