trigger FollowUpTask on Task(before insert) {
    
    List<Task> FUT = new List<Task>();
    integer i=0;
    
    for (Task t: Trigger.new){
        if(t.Follow_Up_Task__c)
        {
            Task CloneTask=t.clone();
            CloneTask.subject='Follow up '+ t.subject;
            CloneTask.ActivityDate=t.ActivityDate + 1;
            CloneTask.Follow_Up_Task__c=false;
            FUT.add(CloneTask);
        }
    }
    
    if(FUT.size()>0)
        insert  FUT;
}