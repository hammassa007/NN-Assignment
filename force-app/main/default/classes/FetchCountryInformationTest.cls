/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Test Class for FetchCountryInformation class
 * @Date         : 05-20-2025
**/
@isTest
public class FetchCountryInformationTest {
    @TestSetup
    static void makeData(){
        Country__c c = new Country__c();
        c.Name='Australia';
        c.Alpha2Code__c='AU';
        c.Alpha3Code__c='AUS';
        c.Capital_City__c='Canberra';
        c.Region__c='Oceania';
        insert c;
    }
    @IsTest
    static void methodName(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.Class, new HttpMockResponseGenerator());
        FetchCountryInformation.fetchAndSyncCountryInfo();
        Test.stopTest();
    }
}