/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : This class checks the validity of Account fields.
 * @Date         : 08-29-2025
**/
public with sharing class AccountValidator {
    // Static map to hold Account fields
    public static Map<String, Schema.SObjectField> fieldMap{
        get {
            if (fieldMap == null) {
                fieldMap = Schema.SObjectType.Account.fields.getMap();
            }
            return fieldMap;
        }
        set;
    }
    
    public String errorMessage;
    // Method to set the error message based on field API name and label
    public void setErrorMessage(String fieldAPIName, String label) {
        errorMessage = fieldMap.get(fieldAPIName).getDescribe().getLabel() + ' ' + label;
        System.debug('====' +errorMessage);
    }

    public Boolean validateRequiredField(Account account) {
        for(String fieldName : fieldMap.keySet()){
            Schema.DescribeFieldResult fieldResult = fieldMap.get(fieldName).getDescribe();

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
