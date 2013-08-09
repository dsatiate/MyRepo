public class NewOpportunity_Controller {
    public id accountId;
    public id OppId{set;get;}
    public List<Opportunity> NonClosedOpportunity{get;set;}
    private final Account acct;
    public PageReference CreatepageRef{set;get;}
    public String CreateOppUrl{set; get;}
    
    public NewOpportunity_Controller(ApexPages.StandardController controller) {
        this.acct = (Account)Controller.getRecord();
        accountId = acct.id;
        NonClosedOpportunity=new List<Opportunity>([SELECT Description, Name, StageName 
                                        FROM Opportunity where AccountId = :accountId AND (NOT StageName like 'Closed%')]);
        CreatepageRef = new PageReference('/006/e?retURL=%2F006%2Fo&accid='+accountId);
        CreateOppUrl= CreatepageRef.getUrl();                              
                                        
    }
    
    public PageReference Editpage(){
        PageReference pageRef = new PageReference('/'+OppId+'/e?retURL=%'+OppId);
        return pageRef;
    }
    
    public PageReference Displaypage(){
        PageReference pageRef = new PageReference('/'+OppId);
        return pageRef;
    }
    
    public void SaveOpp(){
        try{
            update NonClosedOpportunity;
            
        }
        catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Databse Error');
            ApexPages.addMessage(myMsg);
        }
        
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Opportunity Saved Successfully!!!');
        ApexPages.addMessage(myMsg); 
    }    
}