public class TriggerOnEventHandler {
    
    Map<Id,Event> NewEvents;
    Map<Id,Event> oldEvents;
    
    public TriggerOnEventHandler(Map<Id,Event> newValues,Map<Id,Event> oldValues)
    {
        this.NewEvents = newValues;
        this.oldEvents = oldValues;
    }
    
    public void afterInsert()
    {
        EventTriggerService.createTaskInMonday(NewEvents);
    }
}