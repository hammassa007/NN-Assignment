/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Trigger on Opportunity Object
 * @Date         : 06-26-2025
**/

trigger opportunityTrigger on Opportunity (before insert) {
    if(trigger.isBefore && trigger.isInsert){
        UpdateDesrcriptionOnOpportunity.UpdateDesrcriptionField(Trigger.new);
    }
}