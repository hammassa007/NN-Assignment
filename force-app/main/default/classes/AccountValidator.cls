/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : This class checks the validity of Account fields.
 * @Date         : 08-24-2025
**/
public with sharing class AccountValidator {
    // Static map to hold Account fields
    public static Map<String, Schema.SObjectField> accountFieldsMap{
        get {
            if (accountFieldsMap == null) {
                accountFieldsMap = Schema.SObjectType.Account.fields.getMap();
            }
            return accountFieldsMap;
        }
        set;
    }
    
    public String errorMessage;
    // Method to set the error message based on field API name and label
    public void setErrorMessage(String fieldAPIName, String label) {
        errorMessage = accountFieldsMap.get(fieldAPIName).getDescribe().getLabel() + ' ' + label;
        System.debug('====' +errorMessage);
    }

    public Boolean validateRequiredField(Account account) {
        for(String fieldName : accountFieldsMap.keySet()){
            Schema.DescribeFieldResult fieldResult = accountFieldsMap.get(fieldName).getDescribe();

            // Check if the field is required, createable, and not defaulted on create
            if(!fieldResult.isNillable() && fieldResult.isCreateable() && !fieldResult.isDefaultedOnCreate()) {
                // Get the field value
                Object fieldValue = account.get(fieldName);
                System.debug('=====' +fieldValue);
                System.debug('====' +fieldname);

                // If the field value is null or blank, set the error message and return false
                if(fieldValue == null || String.isBlank(String.valueOf(fieldValue))) {
                    setErrorMessage(fieldName, System.Label.Field_Validation);
                    return false;
                }
            }
        }
        return true;
    }
}
