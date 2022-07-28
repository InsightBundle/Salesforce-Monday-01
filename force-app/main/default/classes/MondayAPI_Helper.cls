public class MondayAPI_Helper {
    public static HttpRequest createRquest(String token, String endPointURL , String contentType , String reqMethod) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPointURL);
        req.setMethod(reqMethod);
        req.setHeader('authorization', token);
        req.setHeader('Content-Type', contentType);
        return req;
     }
}