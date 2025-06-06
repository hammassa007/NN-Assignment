/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Apex trigger to populate Country Fields on Lead Object.
 * @Date         : 06-06-2025
**/

trigger populateCountryFieldsOnLead on Country__c (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        GetCountryFieldsOnLead.getCountryFields(trigger.new);
    }
}