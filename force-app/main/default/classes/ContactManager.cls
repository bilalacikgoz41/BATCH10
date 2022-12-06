@RestResource(urlMapping='/Contact/*')
global with sharing class ContactManager {
    //"https://sf10-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Contact/0035h00000pXr1B"

    @HttpGet
    global static Contact getContact() {
        RestRequest request = RestContext.request;
        String uri = request.requestURI;
        Id contactId = uri.substringAfterLast('/');
        Contact con = [SELECT FirstName, LastName, Email, Title, Department FROM Contact WHERE Id = :contactId];
        return con;
    }

    @HttpPost
    global static Id postContact(String FirstName, String LastName, String Email, String Title, String Department) {
        Contact con = new Contact();
        con.FirstName = FirstName;
        con.LastName = LastName;
        con.Email = Email;
        con.Title = Title;
        con.Department = Department;
        insert con;
        return con.Id;
    }

    @HttpDelete 
    global static String deleteContact() {
        RestRequest request = RestContext.request;
        String uri = request.requestURI;
        Id contactId = uri.substringAfterLast('/');
        Contact con = [SELECT Id FROM Contact WHERE Id = :contactId];
        delete con;
        return 'Contact has been deleted successfully!';
    }

    @HttpPut 
    global static Id putContact(String Id, String FirstName, String LastName, String Email, String Title, String Department) {
        Contact con = new Contact();
        con.Id = Id;
        con.FirstName = FirstName;
        con.LastName = LastName;
        con.Email = Email;
        con.Title = Title;
        con.Department = Department;
        upsert con;
        return con.Id;
    }

    @HttpPatch
    global static Contact patchContact() {
        RestRequest request = RestContext.request;
        String jsonString = request.requestBody.toString();
        Contact con = (Contact)JSON.deserialize(jsonString, Contact.class);
        update con;
        Contact newCon = [SELECT FirstName, LastName, Email, Title, Department FROM Contact WHERE Id = :con.Id];
        return newCon;
    }
}