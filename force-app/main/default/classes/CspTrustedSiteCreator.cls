public class CspTrustedSiteCreator {

    /**
     * Creates a new CspTrustedSite record via the Tooling API.
     * @param siteUrl The URL to trust (e.g., 'https://api.example.com').
     * @param siteName A unique developer name for the site (e.g., 'ExampleApiSite').
     */
    @AuraEnabled
    public static void createTrustedSite(String siteUrl, String siteName) {
        
        // Use dynamic URL and Session ID
        String baseUrl = URL.getOrgDomainUrl().toExternalForm();
        String apiUrl = '/services/data/v60.0/sobjects/CspTrustedSite';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(baseUrl + apiUrl);
        req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept', 'application/json');

        // Construct the JSON body with necessary fields
        Map<String, Object> siteData = new Map<String, Object>();
        siteData.put('DeveloperName', siteName);
        siteData.put('MasterLabel', siteName + ' Label');
        siteData.put('EndpointUrl', siteUrl);
        siteData.put('IsActive', true);
        siteData.put('Context', 'All'); // 'All', 'LEX', 'Communities', 'VisualForce', 'Sites'
        
        // Grant access to necessary directives
        siteData.put('IsApplicableToConnectSrc', true); // Essential for API callouts
        siteData.put('IsApplicableToImgSrc', false);
        // Add more directives as needed (StyleSrc, FontSrc, etc.)

        req.setBody(JSON.serialize(siteData));

        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            
            // Check response status
            if (res.getStatusCode() == 201) {
                System.debug('Successfully created CspTrustedSite: ' + siteName);
            } else {
                System.debug(LoggingLevel.ERROR, 'Failed to create CspTrustedSite. Status: ' + res.getStatusCode() + ', Body: ' + res.getBody());
                // Handle errors appropriately (throw exception, log issue, etc.)
            }
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'HTTP Request failed: ' + e.getMessage());
            // Handle exceptions
        }
    }
}
