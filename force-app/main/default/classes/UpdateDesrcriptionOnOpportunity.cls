/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Apex class for updating Description field on created Opportunity.
 * @Date         : 06-26-2025
**/
public without sharing class UpdateDesrcriptionOnOpportunity {
    public static void UpdateDesrcriptionField(List<Opportunity>oppList) {
        for(Opportunity opp : oppList){
            if(opp.Amount != null && opp.Amount > 100000){
                opp.Description= 'Hot Opportunity';
            }
        }
    }
}