public class theController {
    
    private Id accountId = null;
    String searchText;
    List<Account> results;

    Public Id getaccountId(){
        return accountId;
    }
    
    public void setaccountId(String s){
        accountId=(Id)s;
    }
    
    public String getSearchText() {
        return searchText;
    }

    public void setSearchText(String s) {
        searchText = s;
    }

    public List<Account> getResults() {
        return results;
    }

    public PageReference doSearch() {
    
        string NewSearchText='%'+searchText+'%';
                results = (List<Account>)[select id,name,phone from account where name like :NewSearchText];   
                return null;
    }
    public PageReference displaydetail() {
       
        PageReference page = new PageReference('/' + accountId);
        return null;
    }


}