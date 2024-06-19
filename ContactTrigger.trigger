/**
 * ContactTrigger Trigger Description:
 * 
 * The ContactTrigger is designed to handle various logic upon the insertion and update of Contact records in Salesforce. 
 * 
 * Key Behaviors:
 * 1. When a new Contact is inserted and doesn't have a value for the DummyJSON_Id__c field, the trigger generates a random number between 0 and 100 for it.
 * 2. Upon insertion, if the generated or provided DummyJSON_Id__c value is less than or equal to 100, the trigger initiates the getDummyJSONUserFromId API call.
 * 3. If a Contact record is updated and the DummyJSON_Id__c value is greater than 100, the trigger initiates the postCreateDummyJSONUser API call.
 * 
 * Best Practices for Callouts in Triggers:
 * 
 * 1. Avoid Direct Callouts: Triggers do not support direct HTTP callouts. Instead, use asynchronous methods like @future or Queueable to make the callout.
 * 2. Bulkify Logic: Ensure that the trigger logic is bulkified so that it can handle multiple records efficiently without hitting governor limits.
 * 3. Avoid Recursive Triggers: Ensure that the callout logic doesn't result in changes that re-invoke the same trigger, causing a recursive loop.
 * 
 * Optional Challenge: Use a trigger handler class to implement the trigger logic.
 */

trigger ContactTrigger on Contact (before insert, after insert, after update) {
    Set<Id> contactIdsToUpdate = new Set<Id>();
    Set<String> dummyUserIdsToFetch = new Set<String>();

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            for (Contact contact : Trigger.new) {
                if (contact.DummyJSON_Id__c == null) {
                    Integer randomNumber = Math.mod(Crypto.getRandomInteger(), 101);
                    contact.DummyJSON_Id__c = String.valueOf(randomNumber);
                }
                if (Integer.valueOf(contact.DummyJSON_Id__c) <= 100) {
                    dummyUserIdsToFetch.add(contact.DummyJSON_Id__c);
                }
            }
        } else if (Trigger.isUpdate) {
            for (Contact contact : Trigger.new) {
                Contact oldContact = Trigger.oldMap.get(contact.Id);
                if (contact.DummyJSON_Id__c != oldContact.DummyJSON_Id__c) {
                    if (Integer.valueOf(contact.DummyJSON_Id__c) <= 100) {
                        dummyUserIdsToFetch.add(contact.DummyJSON_Id__c);
                    } else if (Integer.valueOf(contact.DummyJSON_Id__c) > 100) {
                        contactIdsToUpdate.add(contact.Id);
                    }
                }
            }
        }

        if (!dummyUserIdsToFetch.isEmpty()) {
            for (String dummyUserId : dummyUserIdsToFetch) {
                DummyJSONCallout.getDummyJSONUserFromId(dummyUserId);
            }
        }

        if (!contactIdsToUpdate.isEmpty()) {
            for (Id contactId : contactIdsToUpdate) {
                DummyJSONCallout.postCreateDummyJSONUser(contactId);
            }
        }
    }
}


// trigger ContactTrigger on Contact(before insert, after insert, after update) {
// 	// When a contact is inserted
//     List<String> contactIdsToCreate = new List<String>();
//     List<String> contactIdsToUpdate = new List<String>();

//     // if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
//     if (Trigger.isBefore) {
//         for (Contact contact : Trigger.new) {
//             if (contact.DummyJSON_Id__c == null) {
//                 Integer randomNumber = Math.round(Math.random() * 100);
//                 contact.DummyJSON_Id__c = String.valueOf(randomNumber);
//             }
//         }
//     }
//     //When a contact is inserted
// 	// if DummyJSON_Id__c is less than or equal to 100, call the getDummyJSONUserFromId API
//     if (Trigger.isAfter) {
//         for (Contact contact : Trigger.new) {
//             if (Trigger.isInsert) {
//                 if (Integer.valueOf(contact.DummyJSON_Id__c) <= 100) {
//                     DummyJSONCallout.getDummyJSONUserFromId(contact.DummyJSON_Id__c);
//                 }
//     //When a contact is updated
// 	// if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
//             } else if (Trigger.isUpdate) {
//                 if (Integer.valueOf(contact.DummyJSON_Id__c) > 100) {
//                     contactIdsToCreate.add(contact.Id);
//                 }
//             }
//         }

//         if (!contactIdsToCreate.isEmpty()) {
//             for (String contactId : contactIdsToCreate) {
//                 DummyJSONCallout.postCreateDummyJSONUser(contactId);
//             }
//         }
//     }
// }
            
        
        
        