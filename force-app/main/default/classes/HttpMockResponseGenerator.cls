/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Mocking HTTP Response
 * @Date         : 05-20-2025
**/
@isTest
global class HttpMockResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req){
        req.setEndpoint('https://test.com');
        HttpResponse res= new HttpResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('[{"name":"Uganda"},{"name":"Germany"}]');
        res.setStatusCode(200);
        return res;
    }
}