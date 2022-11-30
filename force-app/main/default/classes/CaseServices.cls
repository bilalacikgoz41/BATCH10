@RestResource(urlMapping='/Case/*')
global with sharing class CaseServices {
    //https://sf10-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Case/*
    //https://sf10-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Case/5005h00000ZY3jcAAD
    @HttpGet
    global static Case getCase() {
        RestRequest request = RestContext.request;
        String uri = request.requestURI;
        String caseId = uri.substringAfterLast('/');
        Case cs = [SELECT Id, CaseNumber, Priority, Origin, Subject, Description FROM Case WHERE Id = :caseId];
        return cs;
    }

    @HttpPost
    global static Id postCase(String Priority, String Origin, String Subject, String Description) {
        Case cs = new Case();
        cs.Subject = Subject;
        cs.Priority = Priority;
        cs.Origin = Origin;
        cs.Description = Description;
        insert cs;
        return cs.Id;
    }

    /*@HttpPost
    global static List<Case> postCases() {
        RestRequest request = RestContext.request;
        String jsonString = request.requestBody.toString();
        List<Case> cases = (List<Case>)JSON.deserialize(jsonString, List<Case>.class);
        insert cases;
        return cases;
    } */

    @HttpDelete
    global static String deleteCase() {
        RestRequest request = RestContext.request;
        String uri = request.requestURI;
        Integer lastIndex = uri.lastIndexOf('/');
        Id caseId = uri.subString(lastIndex+1);
        Case cs = [SELECT Id FROM Case where Id = :caseId LIMIT 1];
        delete cs;
        return 'Case has been deleted successfully!';
    }

    @HttpPut 
    global static Id putCase(String Id, String Priority, String Origin, String Subject, String Description) {
        Case cs = new Case();
        cs.Id = Id;
        cs.Subject = Subject;
        cs.Priority = Priority;
        cs.Origin = Origin;
        cs.Description = Description;
        upsert cs;
        return cs.Id;
    }

    @HttpPatch
    global static Case patchCase() {
        RestRequest request = RestContext.request;
        String jsonString = request.requestBody.toString();
        //Approach 1
        Case cs = (Case)JSON.deserialize(jsonString, Case.class);
        update cs;
        Case csObj = [SELECT Id, CaseNumber, Priority, Origin, Subject, Description FROM Case WHERE Id = :cs.Id];
        return csObj;
    }


}