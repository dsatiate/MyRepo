trigger oppProdTrigger on OpportunityLineItem (before insert,before update) {
    
    Set<Id> OpportunityIds = new Set<Id>();
   
    Map<string,double> m1= new Map<string,double>();
    Map<string,double> m2= new Map<string,double>(); 
    
    for (OpportunityLineItem oli : Trigger.new)
    {    OpportunityIds.add(oli.OpportunityId);
         if(m2.containsKey((string)oli.OpportunityId)){
             m2.put(oli.OpportunityId,m2.get(oli.OpportunityId)+oli.UnitPrice*oli.Quantity);
         }
         else
         {
             m2.put(oli.OpportunityId,oli.UnitPrice*oli.Quantity);
         }          
    }
    List<AggregateResult> opli = new List<AggregateResult>(
                                        [select OpportunityLineItem.OpportunityId oid,SUM(TotalPrice) sum 
                                        from OpportunityLineItem 
                                        where OpportunityLineItem.OpportunityId 
                                        in: OpportunityIds 
                                        group by OpportunityLineItem.OpportunityId ]); 
                                     
    for(AggregateResult a : opli ){ 
        m1.put((String)a.get('oid'),(Double)a.get('sum'));
        
    } 
    for (OpportunityLineItem oli : Trigger.new){
        if(!m1.containskey((string)oli.OpportunityId)){
            m1.put(oli.OpportunityId,0);        
        }
    }
                                         
    for (OpportunityLineItem oli : Trigger.new){
        double total_price=m1.get((string)oli.OpportunityId)+m2.get((string)oli.OpportunityId);
        if(total_price >50000){
            oli.addError('Total Price for Opportunity ID '+
            (OpportunityIds.contains(oli.OpportunityId)? oli.OpportunityId :'NA')+
             ' is more than the Limit(50000) i.e 50000 <'+total_price);
  
        }
        else{
            m1.put((String)oli.OpportunityId,total_price);
        }
    }
    
    List<Opportunity> oportunityUpdate= new List<Opportunity>(
                                        [select id,Total_Product_Sales_Price__c 
                                        from Opportunity where id in : m1.keyset()]);
    
    for(Opportunity opp:oportunityUpdate){
        opp.Total_Product_Sales_Price__c=m1.get(opp.id); 
    }
    update oportunityUpdate;
}