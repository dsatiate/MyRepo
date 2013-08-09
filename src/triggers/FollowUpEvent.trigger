trigger FollowUpEvent on Event(before insert) {
    
    for (Event t: Trigger.new){
        if(t.Follow_Up_Task__c=true)
        {
            Event FollowUpTask = t.clone();
            FollowUpTask.subject='Follow up '+ t.subject;
            FollowUpTask.ActivityDate=t.ActivityDate + 1;
            insert  FollowUpTask;
        }
    }
}