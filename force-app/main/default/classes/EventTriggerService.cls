public class EventTriggerService {
    public static void createTaskInMonday(Map<Id,Event> newEvents) {
        
        List<Event> events= [Select id, Subject, owner.email ,Description,EndDateTime  
                             FROM Event 
                             WHERE id IN :newEvents.keyset() ];
        for(Event e: events){
            CreateTaskInMonday.createTask(e.subject, e.owner.email , e.Description , Date.ValueOf(e.EndDateTime));
        }
    }
}