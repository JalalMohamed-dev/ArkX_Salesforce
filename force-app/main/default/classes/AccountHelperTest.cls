@IsTest
private class AccountHelperTest {

    @TestSetup
    static void setupData() {
        insert new List<Account>{
            new Account(Name = 'Acme Manufacturing', Industry = 'Manufacturing'),
            new Account(Name = 'TechSoft', Industry = 'Technology'),
            new Account(Name = 'BuildCorp', Industry = 'Manufacturing')
        };
    }

    @IsTest
    static void testGetAccountsByIndustry() {
        List<Account> results = AccountHelper.getAccountsByIndustry('Manufacturing');

        System.assertEquals(2, results.size());
    }

    @IsTest
    static void testGetAccountsByIndustry_Blank() {
        List<Account> results = AccountHelper.getAccountsByIndustry('');

        System.assertEquals(0, results.size());
    }

    @IsTest
    static void testCreateAccount() {
        Id accId = AccountHelper.createAccount('New Test Acc', 'Finance');
        System.assertNotEquals(null, accId);

        Account acc = [
            SELECT Name, Industry FROM Account WHERE Id = :accId
        ];

        System.assertEquals('New Test Acc', acc.Name);
        System.assertEquals('Finance', acc.Industry);
    }

    @IsTest
    static void testCreateAccount_NameMissing() {
        Id result = AccountHelper.createAccount('', 'Finance');
        System.assertEquals(null, result);
    }
}