/**
 * Used to generate a table of resources for the Setup Assistant.
 * 
 * @param url The URL of the resource.
 * @param type The type of the resource.
 * @param name The fullName (developerName) of the resource.
 * 
 */
public class ResourceItem {
    @AuraEnabled public String url;
    @AuraEnabled public String type;
    @AuraEnabled public String name;

    public ResourceItem(String url, String email, String name) {
        this.url = url;
        this.type = email;
        this.name = name;
    }
}