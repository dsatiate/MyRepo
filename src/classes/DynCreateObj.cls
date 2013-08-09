public class DynCreateObj{

    Public PageReference page;
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public sObject sobj{set;get;}
    public String QString{get;set;}
    Public list<SelectOption> PickLOption=new list<SelectOption>();
    Public String CurrentSelection{set;get;}
    public List<String> FieldList=new List<String>();
    
    public void setFieldList(){
        Map <String, Schema.SObjectField> fieldMap = schemaMap.get(CurrentSelection).getDescribe().fields.getMap();
            FieldList.clear();
            if(!fieldMap.isEmpty()){
                for(Schema.SObjectField sfield : fieldMap.Values())
                {
                    FieldList.add(sfield.getDescribe().getName());
                }
            }
    }
    
    public List<String> getFieldList(){
        return FieldList;
    }
    
    public DynCreateObj(){
        PickLOption.add(new SelectOption('None','None'));  
    } 
    
    public List<SelectOption> getPickLOption(){
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();
        PickLOption.clear();
        PickLOption.add(new SelectOption('None','None'));     
        
        for(Schema.SObjectType f : gd)
        {  
            PickLOption.add(new SelectOption(f.getDescribe().getName(),f.getDescribe().getLabel()));
        }
        return PickLOption;
        
    }

    public void QueryDB(){
       
        sobj=null;
        //if(!CurrentSelection.equals('None')){
            try{                
                setFieldList();
                sobj=schemaMap.get(CurrentSelection).newSObject();
                
            }
            catch(Exception e){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Databse Error');
                ApexPages.addMessage(myMsg);
                page=apexpages.CurrentPage();
            }
        //}
       
    }
    
    public PageReference save() {
        try{
            insert sobj;
            page = new PageReference('/' +sobj.id);
                
        }
        catch (Exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Databse Error');
            ApexPages.addMessage(myMsg);
            page=apexpages.CurrentPage();
        }
        return page ;
    }
    
    public PageReference cancel() {
        CurrentSelection=null;
        //sobj=null;
        return new PageReference('/apex/dynCreate');
    }
}