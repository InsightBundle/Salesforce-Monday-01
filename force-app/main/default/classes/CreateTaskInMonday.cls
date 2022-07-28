public class CreateTaskInMonday {
    @future(callout=true)
    public static void createTask(String subject , String OwnerEmail , String description , Date eventDate) {
        String jsonbody ='';
        Integer userId ;
        jsonbody= '{"query": "query { users() { id email}}"}';
        Wrapper wrap = new Wrapper();
        HttpRequest req = MondayAPI_Helper.createRquest(System.Label.Monday_API_Token , System.Label.Monday_API_URL,'application/json','POST');
        Http http = new Http();
        req.setBody(jsonbody);
        HttpResponse res = http.send(req);
        if(res.getStatusCode()==200){
            wrap = (Wrapper) System.JSON.deserialize(res.getBody(), Wrapper.class);
            for(Integer i=0;i<wrap.data.users.size();i++){
                if(wrap.data.users[i].email != null && 
                   OwnerEmail != null &&
                   OwnerEmail.equals(wrap.data.users[i].email)) {
                       userId =wrap.data.users[i].id;
                   }
            }
            jsonbody = '{"query":"mutation{ create_item (board_id: boardId, group_id: \\"groupId\\", item_name: \\"itemName\\" ,column_values:\\"{\\\\\\"person\\\\\\" : \\\\\\"personId\\\\\\", \\\\\\"date4\\\\\\" : \\\\\\"eventDate\\\\\\",\\\\\\"long_text\\\\\\" : \\\\\\"description\\\\\\"}\\") { id }}"}';
            jsonbody = jsonbody.replace('boardId', System.Label.Board_Id);
            jsonbody = jsonbody.replace('groupId', System.Label.Group_Id);
            jsonbody = jsonbody.replace('eventDate', String.ValueOf(eventDate));
            jsonbody = jsonbody.replace('description', Description);
            jsonbody = jsonbody.replace('itemName', subject);
            jsonbody = jsonbody.replace('personId', String.ValueOf(userId));
            
            req.setBody(jsonbody);
            system.debug('req'+req.getBody());
            res = http.send(req);
            if(res.getStatusCode()==200){
                system.debug('Body'+res.getBody());
            }
            else{
                system.debug('Status Code'+ res.getStatusCode());
                system.debug('Body'+res.getBody());
            }
        }
        else{
            system.debug('Status Code'+ res.getStatusCode());
            system.debug('Body'+res.getBody());
        }
    }
    
    
    public class Wrapper
    {
        public Data data;
        public Integer account_id;
    }
    public class Data 
    {
        public List<Users> users;
    }
    
    public class Users 
    {
        Integer id;
        public String email;
    }
}