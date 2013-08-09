public class DynDisplayObj {
   
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public List<sObject> SearchedObject{set; get;}
    
    public String QString{get;set;}

    Public list<SelectOption> PickLOption=new list<SelectOption>();
    Public String CurrentSelection{set;get;}
    
    Public list<SelectOption> PickLOption_field=new list<SelectOption>();
    Public String[] CurrentSelection_field{set;get;}
    
    public DynDisplayObj(){
        PickLOption.add(new SelectOption('None','None'));
        PickLOption_field.add(new SelectOption('None','None'));    
    } 
    
    public List<SelectOption> getPickLOption(){
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();
        PickLOption.clear();
        PickLOption.add(new SelectOption('None','None'));     
        
        for(Schema.SObjectType f : gd)
        {  
            PickLOption.add(new SelectOption(f.getDescribe().getName(),f.getDescribe().getLabel()));
        }
        //PickLOption.sort();
        return PickLOption;
        
    }
    
    public void populatePickList(){
        //http://www.salesforce.com/us/developer/docs/pages/Content/pages_dynamic_vf_sample_standard.htm
        try{
            Map <String, Schema.SObjectField> fieldMap = schemaMap.get(CurrentSelection).getDescribe().fields.getMap();
            
            if(!fieldMap.isEmpty()){
                for(Schema.SObjectField sfield : fieldMap.Values())
                {
                    schema.describefieldresult dfield = sfield.getDescribe();
                    PickLOption_field.add(new SelectOption(dfield.getName(),dfield.getLabel()));
                    
                }
            }
        }
        catch(Exception e){
        
        }    
    }
    
    public List<SelectOption> getPickLOption_field()
    {   PickLOption_field.clear();
        PickLOption_field.add(new SelectOption('None','None'));  
        populatePickList();
        return PickLOption_field;
    }
    
    public void QueryDB(){
        if(!CurrentSelection.equals('None')){
            try{
                QString='Select ';
                CurrentSelection_field.sort();
                for(String s : CurrentSelection_field ){
                    if(!s.equals('None'))
                    QString=QString+' '+s+',';
                }
                QString=QString+' '+'Id';
                QString=QString+' '+'From '+CurrentSelection+' ';
                SearchedObject = Database.query(QString);
            }
            catch(Exception e){
            
            }
        }
    }
}