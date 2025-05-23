/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Apex class to log Exception in the Exception log object in Salesforce.
 * @Date         : 05-23-2025
**/

public without sharing class ExceptionLogger {
    public static void logException(Exception ex, String className, String methodName, String source) {
        try {
            Integer lineNumber = 0;
            String stack = ex.getStackTraceString();
            
            // Extract line number from the first occurrence if available
            Pattern p = Pattern.compile('Class\\.(\\w+):(\\d+)');
            Matcher m = p.matcher(stack);
            if (m.find()) {
                lineNumber = Integer.valueOf(m.group(2));
            }

            Exception_Log__c log = new Exception_Log__c();
            log.Exception_Message__c = ex.getMessage();
            log.Stack_Trace__c = stack;
            log.Class_Name__c = className;
            log.Method_Name__c = methodName;
            log.Line_Number__c = lineNumber;
            log.Source__c = source;
            log.User__c = UserInfo.getUserId();

            insert log;
        } catch (Exception loggingEx) {
            // Avoid recursive logging
            System.debug('Error logging exception: ' + loggingEx.getMessage());
        }
    }
}