/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Utility class for making request
 * @Date         : 06-06-2025
**/

public class UtilityCallOut {
    public static HttpRequest setRequest(httpRequest request, string method, string endpoint){
        request.setMethod(method);
        request.setEndpoint(endpoint);
        return request;
    }
    
    public static HttpResponse sendRequest(HttpRequest request){
        return new http().send(request);
    }
}