public class OpportunityTriggerHandler {
    public static void OpportunityBeforeUpdates(List<Opportunity> newOpportunites) {
        if(Trigger.isBefore && Trigger.isUpdate) {
        for(Opportunity oppToUpdate : newOpportunites) {
            if(oppToUpdate.Amount < 5000) {
                oppToUpdate.Amount.addError('Opportunity amount must be greater than 5000');
            }
        }

        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp : newOpportunites) {
            accountIds.add(opp.AccountId);
        }

        Map<Id, Account> accountAndContact = new Map<Id, Account>(
            [SELECT
                Id,
                    (SELECT Id,
                            AccountId
                    FROM Contacts
                    WHERE Title = 'CEO'
                    ORDER BY FirstName ASC)
            FROM Account
            WHERE Id IN :accountIds
            ]);

            for(Opportunity opp : newOpportunites) {
                if(opp.Primary_Contact__c == null) {
                    Account acc = accountAndContact.get(opp.AccountId);
                    if (acc != null && !acc.Contacts.isEmpty()) {
                        Contact cont = acc.Contacts[0];
                        opp.Primary_Contact__c = cont.Id;
                    }
                }
            }
        }
    }

        public static void OpportunityBeforeDelete(List<Opportunity> newOpportunites) {
            if(Trigger.isBefore && Trigger.isDelete) {
            for(Opportunity oppToDelete : newOpportunites) {
                if(oppToDelete.Account.Industry == 'Banking' || oppToDelete.StageName == 'Closed Won') {
                    oppToDelete.addError('Cannot delete closed opportunity for a banking account that is won');
                }
            }
        }
    }
}
