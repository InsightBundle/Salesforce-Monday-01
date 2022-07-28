global class MockCallOut_Test implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"data": { "users": [{"id": 123456,"email": "test@test.com"}] }, "account_id": 12142312} ');
        response.setStatusCode(200);
        return response; 
      }
 }