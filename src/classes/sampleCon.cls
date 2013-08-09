public class sampleCon {
          
        public String it1{set;get;}
        public String it2{set;get;}
        public String it21{set;get;}
        public String it3{set;get;}
        public String it4{set;get;}
        public String it5{set;get;}
        public String it6{set;get;}
        public String it7{set;get;}
        Public Id idsobj{set;get;}
        Public PageReference page;
        
                
        Public list<SelectOption> PickLOption=new list<SelectOption>();
        Public String CurrentSelection{set;get;}
        
        public void setPickLOption(){
            PickLOption.add(new SelectOption('None','None'));
            PickLOption.add(new SelectOption('Account','Account'));
            PickLOption.add(new SelectOption('Contact','Contact'));
        }
        public list<SelectOption> getPickLOption(){
            return PickLOption;
        }
        
        public sampleCon(){
            setPickLOption();
        }
        
            
        public  sObject createObject(String typeName) {

            Schema.SObjectType targetType = Schema.getGlobalDescribe().get(typeName);
            return targetType.newSObject();
            
        }
        public void testObjectCreation() {
            String typeName = CurrentSelection;
                    
            if (typeName.equals('None')) {
                // throw an exception
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Please Select a Object');
                ApexPages.addMessage(myMsg);
                //page =new PageReference('/apex/newdyn');
                page=apexpages.CurrentPage();
            }
            else{
                sObject a = createObject(typeName);
                if(typeName.equals('Account')){        
                    a.put('name',it1);
                    a.put('phone',it2);
                }
                else{
                    a.put('Firstname',it5);
                    a.put('Lastname',it6);
                    a.put('phone',it21);
                    a.put('Email',it7);
    
        
                }
                try{
                    insert a;
                    idsobj=a.id;
                    page = new PageReference('/' +idsobj);
                
                }
                catch (Exception e) {
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'DML Error');
                    ApexPages.addMessage(myMsg);
                    //page =new PageReference('/apex/newdyn');
                    page=apexpages.CurrentPage();
                }
                
            }
        }
        public PageReference cp() {
                testObjectCreation();
                return page;     
        }
            
}