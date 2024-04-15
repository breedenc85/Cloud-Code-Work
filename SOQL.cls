/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Chad Breeden
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads () {
        return [
                SELECT 
                        Id, 
                        LastName, 
                        Company, 
                        Phone, 
                        Email
                FROM Lead
        ];                            
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getContactsByFirstName () {
        return [
                SELECT 
                        Id,
                        Name
                FROM Contact
                WHERE FirstName = 'John'
        ];
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName () {
        List<Id> contactIds = new List<Id>();
        List<Contact> contList = [
                SELECT 
                    Id
                FROM Contact
                WHERE LastName = 'Smith' OR LastName = 'Jones'
        ];
        for(Contact con : contList) {
            contactIds.add(con.Id);
        }
        return contactIds;
    } 

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> getClosedWonOpportunityCountByAccount (Id accountId) {
        List<Opportunity> closedOpps = [
                SELECT 
                    Id,
                    Name,
                    StageName,
                    CloseDate,
                    AccountId,
                    Amount 
                FROM Opportunity
                WHERE StageName = 'Closed Won' AND AccountId = :accountId
        ];
        return closedOpps;
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer getAccountCount () {
        return [
                SELECT COUNT()
                FROM Account
        ];
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id,Task> getTasksDueNextWeek () {
        Map<Id, Task> tasksDue = new Map<Id, Task>();

        List<Task> tasks = [
                SELECT 
                    Id,
                    ActivityDate 
                FROM Task
        ];

        for(Task task : tasks) {
            if(task.ActivityDate <= Date.today().addDays(7)) {
                tasksDue.put(task.Id, Task);
            }
        }
        return tasksDue;
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsByEmailDomain () {
        List<Contact> contList = [
                SELECT 
                    Id,
                    Name,
                    Email
                FROM Contact
                WHERE Email LIKE '%example.com%'
        ];
        return contList;
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        return [
                SELECT
                    Id,
                    Name
                FROM Opportunity
                WHERE Name LIKE : '%' + keyword + '%'
        ]; 
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        return [
                SELECT 
                    Id,
                    Origin
                FROM Case
                WHERE Origin NOT IN ('Web', 'Email', '')
        ];
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrDescription method to cover this method
     */
    public static List<Lead> getLeadsBySourceOrDescription (String leadSource, String keyword) {
        return [
                SELECT 
                    Id,
                    LeadSource,
                    Title,
                    LastName,
                    Company,
                    Phone,
                    Email
                FROM Lead
                WHERE LeadSource LIKE : '%' + leadSource + '%' OR Title LIKE : '%' + keyword + '%'
        ];
    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
    List<String> contLastNames = new List<String>();

        List<Contact> contacts = [
            SELECT 
                Id,
                AccountId,
                LastName 
            FROM Contact
            WHERE AccountId = :accountId
        ];

        for(Contact con : contacts) {
        contLastNames.add(con.LastName);
        }

        return contLastNames;
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        AggregateResult results = [
                SELECT 
                    SUM(Amount)totalRevenue
                FROM Opportunity
                WHERE StageName = :stage OR Amount > 10000
        ];
        return (Decimal)results.get('totalRevenue');
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        return [
                SELECT 
                    Id,  
                    Name 
                FROM Account
                ORDER BY Name ASC 
                LIMIT 10
        ];
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        return [
                SELECT 
                    Id, 
                    Amount, 
                    CloseDate 
                FROM Opportunity
                WHERE Amount > 100000
                ORDER BY CloseDate ASC 
                LIMIT 5
        ];
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        return [
                SELECT 
                    Id,
                    Birthdate
                FROM Contact
                ORDER BY Birthdate DESC 
                LIMIT 3
        ]; 
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        return [
                SELECT 
                    Id,
                    CreatedDate, 
                    Status 
                FROM Case
                ORDER BY CreatedDate
                LIMIT 10
                OFFSET 5
        ];
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        Set<Id> caseIds = new Set<Id>();

        List<Case> caseList = [
                SELECT 
                    Id,  
                    AccountId
                FROM Case
                WHERE AccountId = :accountId
        ];

        for (Case cases : caseList) {
            caseIds.add(cases.Id);
        }

        return caseIds;
    }


    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        List<Account> accList = [
                SELECT 
                    Id,  
                    Name 
                FROM Account
                WHERE BillingCountry != :country
        ];

        for(Account acc : accList) {
            accountIdsToNames.put(acc.Id, acc.Name);
        }

        return accountIdsToNames;
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        List<Contact> contacts = [
                SELECT 
                    AccountId,
                    Account.Name
                FROM Contact
                WHERE Id = :contactId
        ];
        String accountName;
        for(Contact cont : contacts) {
            accountName = cont.Account.Name;
        }
        return accountName;
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getOpportunityAndAccountNamesForLineItem('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getOpportunityAndAccountNamesForLineItem(Id accountId) {
        List<Account> accountsWithOpportunities = [
                SELECT  
                    Id, 
                    Name, 
                        (SELECT 
                            Id,  
                            Name 
                        FROM Opportunities) 
                    FROM Account 
                    WHERE Id = :accountId
        ];

        if(!accountsWithOpportunities.isEmpty()) {
            Account accountWithOpps = accountsWithOpportunities[0];
            return accountWithOpps;
        } else {
            return null;
        }
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        List<Account> accList = [
                SELECT  
                    Id,  
                    BillingState
                FROM Account 
                WHERE Id = :accountId
        ];

        String billState;
        for(Account acc : accList) {
            billState = acc.BillingState;
        }

        List<Contact> contList = [
                SELECT 
                    Id,  
                    MailingState 
                FROM Contact 
                WHERE MailingState = :billState
        ];
        return contList;
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findContactsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A list of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findContactsByLeadEmailDomains(Set<Id> leadIds) {
        List<Lead> leadEmail = [
                SELECT Email
                FROM Lead
                WHERE Id IN :leadIds
        ];

        Set<String> emailDomains = new Set<String>();

        for (Lead lead : leadEmail) {
            String emailAddress = lead.Email;
            if (emailAddress != null && emailAddress.contains('@')) {
                List<String> parts = emailAddress.split('@');
                emailDomains.add(parts[1]);
            }
        }

        String query = 'SELECT Id, Website FROM Account WHERE Website LIKE ';
        for (String emailDomain : emailDomains) {
            query += '\'' + '%' + emailDomain + '\'' + ' OR Website LIKE ';
        }
        query = query.substring(0, query.lastIndexOf(' OR Website LIKE'));

        List<Account> matchingAccounts = Database.query(query);

        return matchingAccounts;
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        List<OpportunityLineItem> origLineItems = [
                SELECT 
                    OpportunityId, 
                    Product2Id, 
                    Quantity, 
                    UnitPrice, 
                    PriceBookEntryId
                FROM OpportunityLineItem
                WHERE OpportunityId = :origOppId
        ];
        
        List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();
        Integer randomNumber = Integer.valueOf(Math.floor(Math.random() * 3) + 1);
        
        for (Id cloneOppId : cloneOppIds) {
            for (OpportunityLineItem origLineItem : origLineItems) {
                    OpportunityLineItem newLineItem = origLineItem.clone(
                    false,
                    true,
                    false,
                    false
                    );
            newLineItem.Quantity += randomNumber;
            newLineItem.OpportunityId = cloneOppId;
                if (origLineItem.PricebookEntryId != null) {
                    newLineItem.PricebookEntryId = origLineItem.PricebookEntryId;
                }
                newLineItems.add(newLineItem);
            }
        }
        insert newLineItems;
    }
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() { 
        List<Opportunity> oppList = [
                SELECT 
                    Id,  
                    Name, 
                    Account.Name,
                    Owner.Name 
                FROM Opportunity
                WHERE StageName = 'Closed Won'
        ];
        return oppList; 
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for the provided Opportunities from the first related Contact of the Account, ordered by first name.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     * @param A list of 'Closed Won' Opportunities.
     */
    public static void setPrimaryContact() {
        List<Opportunity> opps = SOQL.getOpportunityDetailsForClosedWon();
        Set<Id> accId = new Set<Id>();

        for(Opportunity opp : opps){
            accId.add(opp.AccountId);
        }

        List<Contact> cont = [
                SELECT 
                    Id,
                    FirstName,
                    LastName,
                    AccountId
                FROM Contact 
                WHERE AccountId IN :accId
                ORDER BY FirstName
        ];

        Map<Id, Contact> accountToContactMap = new Map<Id, Contact>();
        for(Contact con : cont) {
            if(!accountToContactMap.containsKey(con.AccountId)) {
            accountToContactMap.put(con.AccountId, con);
            }
        }

        for(Opportunity oppToUpdate : opps){
            Contact primaryContact = accountToContactMap.get(oppToUpdate.AccountId);
            if(primaryContact != null){
                oppToUpdate.Primary_Contact__c = primaryContact.Id;
            }
        }
        update opps;
    }
}