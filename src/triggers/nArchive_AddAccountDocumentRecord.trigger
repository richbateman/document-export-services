trigger nArchive_AddAccountDocumentRecord on LLC_BI__AccountDocument__c (after update) {
List<nArchive__nArchive__c> nArchiveList=new List<nArchive__nArchive__c>();
List<nArchive__nArchiveSettings__c> ns = nArchive__nArchiveSettings__c.getall().values();
List<Account> Acct = new List<Account>();
    
for(LLC_BI__AccountDocument__c AcctDoc : Trigger.new){
    // Access old value
    LLC_BI__AccountDocument__c oldAcctDoc = Trigger.oldMap.get(AcctDoc.Id);
        if(ns[0].nArchive__Type__c == 'DocStatus'){
         if(String.valueof(AcctDoc.LLC_BI__reviewStatus__c) == ns[0].nArchive__DocStatus__c && 
           String.valueof(oldAcctDoc.LLC_BI__reviewStatus__c) != ns[0].nArchive__DocStatus__c && 
           String.isNotBlank(AcctDoc.LLC_BI__attachmentId__c)){
               
            nArchive__nArchive__c addRecord = new nArchive__nArchive__c (
              nArchive__AccountDocument__c = AcctDoc.Id,
              nArchive__Current_Attachment_Id__c = AcctDoc.LLC_BI__attachmentId__c,
              nArchive__Account__c = AcctDoc.LLC_BI__Account__c,
              nArchive__UID__c = AcctDoc.LLC_BI__attachmentId__c + AcctDoc.LLC_BI__Account__c
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