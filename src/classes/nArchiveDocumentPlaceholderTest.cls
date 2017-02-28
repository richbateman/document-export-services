@isTest

private class nArchiveDocumentPlaceholderTest {
private static testMethod void validatenArchive() {
nArchiveSettings__c settings = nArchiveSettings__c.getInstance();
Account testAccount = new Account(name='nArchive_Account_Test');
insert testAccount;

settings.clear();
if(settings.id == null) {
    settings = new nArchiveSettings__c();
    settings.Name = 'Test';
    settings.Type__c = 'DocStatus';
    settings.DocStatus__c = 'Approved';
    insert settings;
			LLC_BI__Document_Placeholder__c  testDocPlace3 = new LLC_BI__Document_Placeholder__c (Name='nArchiveTest4',NDOC__Account__c=testAccount.Id, LLC_BI__Review_Status__c = 'In-File');
            insert testDocPlace3;
            LLC_BI__Document_Placeholder__c  n4 = new LLC_BI__Document_Placeholder__c (Id = testDocPlace3.Id, NDOC__Attachment_Id__c = '8384858687', LLC_BI__Review_Status__c = 'Approved');
            update n4;
            n4 = [SELECT LLC_BI__Review_Status__c FROM LLC_BI__Document_Placeholder__c  WHERE Id = : n4.Id];
            System.assertEquals('Approved', n4.LLC_BI__Review_Status__c );
			}
    }
}