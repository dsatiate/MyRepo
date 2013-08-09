public class RowEditingcontroller {

    private Id accountId {get;set;}
    public List<Opportunity> results=null;
    public string a;
    
    Public List<Opportunity> getresults(){
        return results;
    }
    
    public RowEditingcontroller(ApexPages.StandardController stdController){}
    
    public RowEditingcontroller() {
        accountId=ApexPages.currentPage().getParameters().get('id');
        results = new List<Opportunity>([select id,name from Opportunity where id= :accountId]);
        a=(string)accountId;
    }
    
    public void search(){
        accountId=ApexPages.currentPage().getParameters().get('id');
        results = new List<Opportunity>([select id,name from Opportunity where id= :accountId]);
        a=(string)accountId;
    }
 }