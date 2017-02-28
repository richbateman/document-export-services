@isTest

private class nArchiveLoanDocumentTest {
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
            LLC_BI__Loan__c testLoan = new LLC_BI__Loan__c(name='nArchive_Loan_Test');
            insert testLoan;
    
            LLC_BI__LLC_LoanDocument__c testLoanDoc = new LLC_BI__LLC_LoanDocument__c(Name='nArchiveTest',LLC_BI__Loan__c=testLoan.Id, LLC_BI__reviewStatus__c = 'In-File');
            insert testLoanDoc;
            LLC_BI__LLC_LoanDocument__c l = new LLC_BI__LLC_LoanDocument__c(Id = testLoanDoc.Id, LLC_BI__attachmentId__c = '0123456789', LLC_BI__reviewStatus__c = 'Approved');
            update l;
            l = [SELECT LLC_BI__reviewStatus__c  FROM LLC_BI__LLC_LoanDocument__c WHERE Id = : l.Id];
            System.assertEquals('Approved',l.LLC_BI__reviewStatus__c);

			}
    }
}