@isTest

private class nArchiveAccountDocumentTest {
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
            LLC_BI__AccountDocument__c   testDocPlace3 = new LLC_BI__AccountDocument__c  (Name='nArchiveTest4',LLC_BI__Account__c =testAccount.Id, LLC_BI__reviewStatus__c  = 'In-File');
            insert testDocPlace3;
            LLC_BI__AccountDocument__c   n4 = new LLC_BI__AccountDocument__c  (Id = testDocPlace3.Id, LLC_BI__attachmentId__c  = '8384858687', LLC_BI__reviewStatus__c  = 'Approved');
            update n4;
            n4 = [SELECT LLC_BI__reviewStatus__c  FROM LLC_BI__AccountDocument__c   WHERE Id = : n4.Id];
            System.assertEquals('Approved', n4.LLC_BI__reviewStatus__c  );
            
			}
    }
}