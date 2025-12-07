public with sharing class AccountHelper {

    /**
     * Returns a list of Accounts by Industry.
     * No exceptions. If access is denied, returns empty list.
     */
    public static List<Account> getAccountsByIndustry(String industryName) {

        if (String.isBlank(industryName)) {
            return new List<Account>();
        }

        // Access check — return empty list if not allowed
        if (!Schema.sObjectType.Account.isAccessible()) {
            return new List<Account>();
        }

        return [
            SELECT Id, Name, Industry, AnnualRevenue
            FROM Account
            WHERE Industry = :industryName
            ORDER BY Name
        ];
    }


    /**
     * Creates a new Account.
     * If create access is denied or name is blank, returns null.
     */
    public static Id createAccount(String name, String industry) {

        if (String.isBlank(name)) {
            return null;
        }

        if (!Schema.sObjectType.Account.isCreateable()) {
            return null;
        }

        Account acc = new Account(
            Name = name,
            Industry = industry
        );

        insert acc;

        return acc.Id;
    }
}