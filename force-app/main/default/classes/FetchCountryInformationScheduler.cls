/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Scheduler class for schedulling fetchCountryInformation method.
 * @Date         : 05-20-2025
**/

global class FetchCountryInformationScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        FetchCountryInformation.fetchAndSyncCountryInfo();
    }
}