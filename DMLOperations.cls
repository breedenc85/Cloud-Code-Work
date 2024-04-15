/**
 * The DMLOperations class serves as a deep dive into Data Manipulation Language (DML) in Apex.
 * It covers fundamental DML operations such as insert, update, upsert, and delete.
 *
 * This class introduces developers to the concept of manipulating Salesforce records in Apex.
 * It discusses how to use DML operations to create, update, and delete records.
 * This class uses standard Salesforce objects like Account, Contact, and Opportunity for demonstration.
 *
 * Topics covered in this class include:
 * - Understanding how to use insert DML operation to create records in Salesforce.
 * - Understanding how to use update and upsert DML operations to update existing records in Salesforce.
 * - Understanding how to use delete DML operation to remove records from Salesforce.
 *
 * Users of this class can expect to gain a strong understanding of DML operations in Apex and
 * be prepared for more advanced topics in Salesforce development.
 *
 * The methods within this class serve as practical examples of different DML operations,
 * allowing developers to learn through practice and examples.
 *
 * @author Chad Breeden
 */


public with sharing class DMLOperations {

    /**
     * Question 1
     * Create a new Account object and inserts it into the database.
     * The Account will have a random name for uniqueness.
     * @return The Id of the newly created Account.
     */
    public static Id insertNewAccount() {
        Account acc = new Account(name = 'Test Account', Rating = 'Hot');
        insert acc;
        return acc.Id;
    }

    /**
     * Question 2
     * Create a new Account with the specified name and industry provided.
     * @param name The name of the account to be created.
     * @param industry The industry of the account to be created.
     */
    public static void createAccount(String name, String industry) {
        Account acc = new Account(name = name, industry = industry);
        insert acc;        
    }
    
    /**
     * Question 3
     * Create a new Contact and link it to the Account id provided then inserts it into the database.
     * @param accountId The Id of the Account to link the Contact to.
     * @return The Id of the newly created Contact.
     */
    public static Id insertNewContact(Id accountId) {
        Contact cont = new Contact(LastName = 'Test', title = 'CEO', accountId = accountId);
        insert cont;
        return cont.Id;
    }

    /**
     * Question 4
     * Update the last name of a Contact in the database.
     * Resource: https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm
     * @param contactId The Id of the Contact to update.
     * @param newLastName The new last name for the Contact.
     */
    public static void updateContactLastName(Id contactId, String newLastName) {
        Contact cont = [SELECT Id FROM Contact WHERE Id = :contactId];
        cont.LastName = newLastName;
        update cont;
    }

    /**
     * Question 5
     * Update the stage of an Opportunity in the database.
     * Resource: https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm
     * @param oppId The Id of the Opportunity to update.
     * @param newStage The new stage for the Opportunity.
     */
    public static void updateOpportunityStage(Id oppId, String newStage) {
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Id = :oppId];
        opp.StageName = newStage;
        update opp;
    }

    /**
     * Question 6
     * Update the Account's Name and Industry given an Account Id.
     * Resource: https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm
     * @param accountId The Id of the account to be updated.
     * @param newName The new name for the account.
     * @param newIndustry The new industry for the account.
     */
    public static void updateAccountFields(Id accountId, String newName, String newIndustry) {
            Account acc = new Account(Id = accountId, Name = newName, Industry = newIndustry);
            update acc;
    }

    /**
     * Question 7
     * Create or updates an Opportunities
     * The Opportunity's Stage is set to Qualification.
     * The Opportunity's Close Date is set to 3 months from today.
     * The Opportunity's Amount is set to 50000.
     * @param list of Opportunities to be changed then upserted.
     */
    public static void upsertOpportunityList(List<Opportunity> opportunities) {
        for(Opportunity opp : opportunities) {
            opp.StageName = 'Qualification';
            opp.CloseDate = Date.today().addMonths(3);
            opp.Amount = 50000;
        }
        upsert opportunities;
    }

    /**
    * Question 8
    * Insert or updates opportunities from list of names.
    * Associate the Opportunities with account that has the name accountName.
    * There should be an Opportunity for each name provided in the list.
    * @param accountName The name of the Account.
    * @param oppNames The list of Opportunity names.
    */
    public static void upsertOpportunities(String accountName, List<String> oppNames) {
        Account acc = new Account();
        List<Account> accList = [SELECT Id, Name FROM Account WHERE Name = :accountName LIMIT 1];
        if(accList.isEmpty()) {
            acc.Name = accountName;
            insert acc;
        } else {
            acc = accList[0];
        }

        List<Opportunity> oppList = new List<Opportunity>();
        List<Opportunity> existingOpps = [SELECT Id, Name FROM Opportunity WHERE Account.Name = :accountName];

        for(String oppName : oppNames) {
            Boolean opportunityExists = false;
                for(Opportunity existingOpp : existingOpps) {
                    if(existingOpp.Name == oppName) {
                    opportunityExists = true;
                    break;
                    }
                }

            if(!opportunityExists) {
                Opportunity newOpp = new Opportunity();
                newOpp.AccountId = acc.Id;
                newOpp.Name = oppName;
                newOpp.StageName = 'New';
                newOpp.CloseDate = Date.today().addMonths(3);
                oppList.add(newOpp);
            }
        } 
        upsert oppList;
    }

    /**
     * Question 9
	 * Upserts an Account with the specified name.
	 * If an Account with the given name already exists, it updates that Account.
	 * If no such Account exists, it creates a new one.
	 * @param accountName The name of the Account to be upserted.
	 * @return The Account that was upserted.
	 */
	public static Account upsertAccount(String accountName) {
        Account acc;
		List<Account> accList = [SELECT Id, Name FROM Account WHERE Name =: accountName];
        if(!accList.isEmpty()) {
            acc = accList[0];
            acc.Description = 'Updated Account';
        } else {
            acc = new Account(Name = accountName);
        }
        upsert acc;
        return acc;
	}

    /**
     * Question 10
	 * Upserts accounts and links contacts to them based on the contact's last name and account name.
	 * Create or use existing account with contact last name. (Hint: use previous upsertAccount method)
	 * Contacts are then linked to these accounts based on a full last name match.
     * Example Contact Last Name = Doe Link to Account Name = Doe 
     * Example Contact Last Name = Jane Link to Account Name = Jane
	 * @param contactsToUpsert List of Contacts to be upserted and linked to accounts.
	 */
	public static void upsertAccountsWithContacts(List<Contact> contactsToUpsert) {
        String accountName;
        List<Contact> contactsToUpdate = new List<Contact>();
        for(Contact singleContact : contactsToUpsert) {
            accountName = singleContact.LastName;
            Account acc = upsertAccount(accountName);
            singleContact.AccountId = acc.Id;
            contactsToUpdate.add(singleContact);
        }
        upsert contactsToUpdate;
    }

    /**
     * Question 11
     * Insert a list of Leads and then deletes them.
     * @param leadNames The list of Lead names to be inserted.
     */
    public static void insertAndDeleteLeads(List<String> leadNames) {
        List<Lead> leadsToInsert = new List<Lead>();
        for(String lead : leadNames){
            Lead newLead = new Lead(LastName = lead, Company = 'Komodo Health');
            leadsToInsert.add(newLead);
        }
        
        List<Lead> leadsToDelete = [SELECT Id FROM Lead WHERE Name IN: leadNames];
        delete leadsToDelete;
    }
    
    /**
     * Question 12
     * Dynamically create the number of cases and relate it to the accountId, then deletes them.
     * @param accountId The account for which the cases will be created and then deleted.
     * @param numOfCases The number of cases to create.
     */
    public static void createAndDeleteCases(String accountId, Integer numOfCases) {
        List<Case> casesToInsert = new List<Case>();
        for(Integer i = 0; i < numOfCases; i++) {
            Case newCase = new Case(AccountId = accountId);
            casesToInsert.add(newCase);
        }
        insert casesToInsert;

        List<Case> casesToDelete = [SELECT Id FROM Case WHERE AccountId =: accountId];
        delete casesToDelete;
    }
}