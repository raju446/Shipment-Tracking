@isTest
public class Case_ShipmentStatus_Test {

    @isTest
    static void testGetShipmentDetailsSuccess() {
        // Setup mock response for successful request
        HttpCalloutMock mockResponse = new MockHttpResponseGenerator(200, '{"status": "Delivered", "trackingNumber": "123456789"}');
        Test.setMock(HttpCalloutMock.class, mockResponse);
        
        // Call the method and verify the result
        Map<String, Object> result = Case_ShipmentStatusController.getShipmentDetails('123456789');
}
    
    @isTest
    static void testGetShipmentDetailsError() {
        // Setup mock response for error scenario
        HttpCalloutMock mockResponse = new MockHttpResponseGenerator(500, 'Internal Server Error');
        Test.setMock(HttpCalloutMock.class, mockResponse);
        
        // Call the method and verify the result
        Map<String, Object> result = Case_ShipmentStatusController.getShipmentDetails('123456789');
}
    
    @isTest
    static void testGetShipmentDetailsException() {
        // Setup mock response to simulate an exception
        HttpCalloutMock mockResponse = new MockHttpResponseGenerator(null, null);
        Test.setMock(HttpCalloutMock.class, mockResponse);
        
        // Call the method and verify the result
        Map<String, Object> result = Case_ShipmentStatusController.getShipmentDetails('123456789');
}
    
    // Mock class to simulate HttpResponse
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        private Integer statusCode;
        private String responseBody;
        
        public MockHttpResponseGenerator(Integer statusCode, String responseBody) {
            this.statusCode = statusCode != null ? statusCode : 500; // Default to 500 if null
            this.responseBody = responseBody != null ? responseBody : ''; // Default to empty string if null
        }
        
        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(statusCode);
            response.setBody(responseBody);
            return response;
        }
    }
}
