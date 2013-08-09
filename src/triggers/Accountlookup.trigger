trigger Accountlookup on Batch__c (before insert, before update) 
{
   
    set<string> setcompanyname=new set<string>();
    Map<string,Id> mapAccount=new Map<string,Id>();
    
    for(Batch__c batchObj:Trigger.new)
    {
    
       setcompanyname.add(batchObj.Company_Name__c);
        
    }
    List<Account> lstAccount=[select id,name from account where name in: setcompanyname];
    for(Account a:lstAccount)
    {
       if(!mapAccount.containsKey(a.name))
       {
           mapAccount.put(a.name,a.id);
       }
    }
    if(mapAccount.size()>0)
    {
       for(Batch__c b:Trigger.new)
       {
           if(mapAccount.containsKey(b.Company_Name__c))
           {
               b.Account__c=mapAccount.get(b.Company_Name__c);
           }
       }
   }
}