/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Trigger on Account object
 * @Date         : 06-26-2025
**/

trigger accountTrigger on Account (before insert) {
    if(trigger.isBefore && trigger.isInsert){
        UpdateAccountRating.updateRatingOfAccount(Trigger.new);
    }
}