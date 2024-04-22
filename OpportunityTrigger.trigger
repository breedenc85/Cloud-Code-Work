trigger OpportunityTrigger on Opportunity (before insert, before update, before delete) {
    OpportunityTriggerHandler.OpportunityBeforeUpdates(Trigger.new);
    OpportunityTriggerHandler.OpportunityBeforeDelete(Trigger.old);
}