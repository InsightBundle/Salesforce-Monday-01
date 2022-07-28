trigger TriggerOnEvent on Event (after insert) {
    TriggerOnEventHandler handler = new TriggerOnEventHandler(trigger.newMap,trigger.oldMap);
    
    if(trigger.isAfter){
        if(trigger.isInsert){
            handler.afterInsert();
        }
    }
}