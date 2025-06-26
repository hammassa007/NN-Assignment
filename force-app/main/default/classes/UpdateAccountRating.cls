/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Apex class to update Account Rating field based on the Industry field value.
 * @Date         : 06-26-2025
**/

public without sharing class UpdateAccountRating {
    public static void updateRatingOfAccount(List<Account>accList) {
        for(Account acc : accList){
            if(acc.Industry != null && acc.Industry == 'Media'){
                acc.Rating = 'Hot';
            }
        }
    }
}