trigger nArchive_AddLoanDocumentRecord on LLC_BI__LLC_LoanDocument__c (after update) {
List<nArchive__nArchive__c> nArchiveList=new List<nArchive__nArchive__c>();
List<nArchive__nArchiveSettings__c> ns = nArchive__nArchiveSettings__c.getall().values();

for(LLC_BI__LLC_LoanDocument__c LoanDoc : Trigger.new){
    LLC_BI__LLC_LoanDocument__c oldLoanDoc = Trigger.oldMap.get(LoanDoc.Id);
        if(ns[0].nArchive__Type__c == 'DocStatus'){
        if(String.valueof(LoanDoc.LLC_BI__reviewStatus__c) == ns[0].nArchive__DocStatus__c && 
           String.valueof(oldLoanDoc.LLC_BI__reviewStatus__c) != ns[0].nArchive__DocStatus__c && 
           String.isNotBlank(LoanDoc.LLC_BI__attachmentId__c)){
               
            nArchive__nArchive__c addRecord = new nArchive__nArchive__c (
              nArchive__LLC_LoanDocument__c = LoanDoc.Id,
              nArchive__Current_Attachment_Id__c = LoanDoc.LLC_BI__attachmentId__c,
              nArchive__Loan__c = LoanDoc.LLC_BI__Loan__c,
              nArchive__Account__c = LoanDoc.LLC_BI__Loan__r.LLC_BI__Account__c,
              nArchive__UID__c = LoanDoc.LLC_BI__attachmentId__c + LoanDoc.LLC_BI__Loan__c
            );
               //insert addRecord;
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