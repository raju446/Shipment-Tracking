public class Case_ShipmentStatusController {
    /**
     * Retrieves shipment details from an external service based on the provided tracking number.
     * @param trackNumber The shipment tracking number.
     * @return A map containing the result of the request and any error information.
     */
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getShipmentDetails(String trackNumber) {
        Map<String, Object> result = new Map<String, Object>(); // Initialize the result map to hold response data and error information
        
        try {
            // Create HTTP objects to send the request
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            
            // Define the endpoint for the external service
            String endpoint = 'https://merzcommunities--tina.sandbox.my.salesforce-sites.com/services/apexrest/mockShipmentStatus?';
            
            // Append the tracking number as a query parameter if it's not null
            if (trackNumber != null) {
                endpoint += 'trackingNumber=' + EncodingUtil.urlEncode(trackNumber, 'UTF-8');
            } 
            
            // Configure the HTTP request
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            
            // Send the HTTP request and receive the response
            HttpResponse response = http.send(request);

            // Process the HTTP response based on the status code
            if (response.getStatusCode() == 200) {
                // If the response is successful, put the response body in the result map
                result.put('hasError', false);
                result.put('message', response.getBody());
            } else {
                // If the response is not successful, set an error message
                result.put('hasError', true);
                result.put('message', 'Error retrieving shipment status.');
            }
        } catch (Exception e) {
            // Handle any exceptions by putting the error message in the result map
            result.put('hasError', true);
            result.put('message', 'Exception: ' + e.getMessage());
        }
        
        return result; // Return the result map
    }
}
