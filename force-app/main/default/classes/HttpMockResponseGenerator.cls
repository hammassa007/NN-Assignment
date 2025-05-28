/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Mocking HTTP Response
 * @Date         : 05-28-2025
**/
@isTest
global class HttpMockResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req){
        HttpResponse res= new HttpResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('[{"name":"Australia", "alpha2Code":"AU", "alpha3Code":"AUS", "capital":"Canberra", "region":"Oceanic"},{"name":"Afghanistan", "alpha2Code":"AF", "alpha3Code":"AFG", "capital":"Kabul", "region":"Asia"}]');
        res.setStatusCode(200);
        return res;
    }
}