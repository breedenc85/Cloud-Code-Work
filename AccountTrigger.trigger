trigger AccountTrigger on Account (before insert, after insert) {
    AccountTriggerHandler.AccountBeforeUpdates(Trigger.new);
    AccountTriggerHandler.AccountAfterUpdates(Trigger.new);
}