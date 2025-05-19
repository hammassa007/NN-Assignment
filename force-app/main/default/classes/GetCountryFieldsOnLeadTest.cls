/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Test class for GetCountryFieldsOnLead class.
 * @Date         : 05-20-2025
**/

@isTest
public class GetCountryFieldsOnLeadTest {
    @testSetup
    static void setupTestData() {
        List<Country__c> countryList = new List<Country__c>();
        Country__c cl = new Country__c();
        cl.Name='Australia';
        cl.Alpha2Code__c='AU';
        cl.Alpha3Code__c='AUS';
        cl.Capital_City__c='Canberra';
        cl.Region__c='Oceania';
        countryList.add(cl);

        Country__c c = new Country__c();
        c.Name = 'India';
        c.Alpha2Code__c = 'IN';
        c.Alpha3Code__c = 'IND';
        c.Capital_City__c = 'New Delhi';
        c.Region__c = 'Asia';
        countryList.add(c);
            
        insert countryList;

        List<Lead> leads = new List<Lead>();
        for (Country__c co : countryList) {
            Lead l = new Lead();
            l.Country__c = co.Id;
            l.Country_Alpha2Code__c = co.Alpha2Code__c;
            l.Country_Alpha3Code__c = co.Alpha3Code__c;
            l.Country_Capital__c = co.Capital_City__c;
            l.Country_Region__c = co.Region__c;
            l.LastName = 'Test' + co.Name;
            l.Company = 'Test Company';
            leads.add(l);
        }
        insert leads;
    }

    @isTest
    static void testGetCountryFields() {
        List<Country__c> countryList = [SELECT Id, Name, Alpha2Code__c, Alpha3Code__c, Capital_City__c, Region__c FROM Country__c];

        Test.startTest();
        GetCountryFieldsOnLead.getCountryFields(countryList);
        Test.stopTest();
   
    }
}