@isTest
public class CreateTaskInMonday_Test {
    @isTest
    public static void createTask_Test(){
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockCallOut_Test());
        CreateTaskInMonday.createTask('Test', 'test@test.com' , 'Test Class', System.today());
        test.stopTest();
    }
    
}