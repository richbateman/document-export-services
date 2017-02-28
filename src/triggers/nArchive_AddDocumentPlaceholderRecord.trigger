trigger nArchive_AddDocumentPlaceholderRecord on LLC_BI__Document_Placeholder__c (after update) {
List<nArchive__nArchive__c> nArchiveList=new List<nArchive__nArchive__c>();
List<nArchive__nArchiveSettings__c> ns = nArchive__nArchiveSettings__c.getall().values();

for(LLC_BI__Document_Placeholder__c DocPlace : Trigger.new){
    LLC_BI__Document_Placeholder__c oldDocPlace = Trigger.oldMap.get(DocPlace.Id);
        if(ns[0].nArchive__Type__c == 'DocStatus'){
        if(String.valueof(DocPlace.LLC_BI__Review_Status__c) == ns[0].nArchive__DocStatus__c && 
           String.valueof(oldDocPlace.LLC_BI__Review_Status__c) != ns[0].nArchive__DocStatus__c && 
           String.isNotBlank(DocPlace.NDOC__Attachment_Id__c)){
               
            nArchive__nArchive__c addRecord = new nArchive__nArchive__c (
              nArchive__Document_Placeholder__c = DocPlace.Id,
              nArchive__Current_Attachment_Id__c = DocPlace.NDOC__Attachment_Id__c,
              nArchive__Account__c = DocPlace.NDOC__Account__c,
              nArchive__UID__c = DocPlace.NDOC__Attachment_Id__c + DocPlace.Id
            );  
            nArchiveList.add(addRecord);
        }
    } 
try 
{
    if(!nArchiveList.isEmpty())
        insert nArchiveList;
}
catch (Exception Ex) 
{
    system.debug(Ex);
}       
} 
}