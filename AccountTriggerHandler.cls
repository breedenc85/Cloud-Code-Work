public class AccountTriggerHandler {
    public static void AccountBeforeUpdates(List<Account> newAccounts) {
        if(Trigger.isBefore && Trigger.isInsert) {
            for(Account acc : newAccounts) {
                if (acc.Type == null) {
                    acc.Type = 'Prospect';
                }

                if (acc.ShippingStreet != null &&
                    acc.ShippingCity != null &&
                    acc.ShippingState != null &&
                    acc.ShippingPostalCode != null &&
                    acc.ShippingCountry != null) 
                    {
                    acc.BillingStreet       = acc.ShippingStreet;
                    acc.BillingCity         = acc.ShippingCity;
                    acc.BillingState        = acc.ShippingState;
                    acc.BillingPostalCode   = acc.ShippingPostalCode;
                    acc.BillingCountry      = acc.ShippingCountry;
                    }
                
                if (acc.Phone != null &&
                    acc.Website  != null &&
                    acc.Fax != null) {
                        acc.Rating = 'Hot';
                }
            }
        }
    }

    public static void AccountAfterUpdates(List<Account> newAccounts) {
        if(Trigger.isAfter && Trigger.isInsert) {
        List<Contact> contactsToInsert = new List<Contact>();
            for(Account acc : newAccounts) {
                Contact newContact = new Contact(
                    AccountId = acc.Id,
                    LastName = 'DefaultContact',
                    Email = 'default@email.com'
                );
                contactsToInsert.add(newContact);          
            }
            insert contactsToInsert;
        }
    }
}
