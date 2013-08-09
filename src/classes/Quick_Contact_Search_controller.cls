public class Quick_Contact_Search_controller {

    public String ce { get; set; }

    public String an { get; set; }

    public String cn { get; set; }
    
    public String SearchMessage { get; set; }
    
    public List<Contact> SearchedContact { set; get; }
    
    public Quick_Contact_Search_controller(){
        
        ce =ApexPages.currentPage().getParameters().get('ce');
        an =ApexPages.currentPage().getParameters().get('an');
        cn =ApexPages.currentPage().getParameters().get('cn');
        SearchContact();
    }
    
    
    public void SearchContact() {
        if(String.isBlank(ce) && String.isBlank(cn) && String.isBlank(an)){
            //ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter search parameters to search contacts');
            //ApexPages.addMessage(myMsg);
            SearchMessage ='Please enter search parameters to search contacts';
        }
        else{
            SearchMessage ='';
            string SearchCe='%'+ce+'%';
            string SearchAn='%'+an+'%';
            string SearchCn='%'+cn+'%';
            String QueryString= 'select id, Account.name, Name, Email from Contact where ';
            
            if(!String.isBlank(an)){
                QueryString=QueryString +'Account.name like :SearchAn ';
            }
            if(!String.isBlank(cn)){
                if(!String.isBlank(an)){
                    QueryString=QueryString +'AND ';
                }
                QueryString=QueryString +' Name like :SearchCn ';
            }
            if(!String.isBlank(ce)){                
                if(!String.isBlank(an) || !String.isBlank(cn)){
                    QueryString=QueryString +'AND ';
                }
                QueryString=QueryString +' Email like :SearchCe ';
            }
            
            SearchedContact = Database.query(QueryString);
        }

    }

    
}