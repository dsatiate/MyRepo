public class quickedit {
    List<Opportunity> results;
    public quickedit() {
        results=(List<Opportunity>)[SELECT Id, Name FROM Opportunity
                WHERE Account.id = :ApexPages.currentPage().getParameters().get('Id')];
    }

    
    public  quickedit(ApexPages.StandardSetController controller) {
                results=(List<Opportunity>)[SELECT Id, Name FROM Opportunity
                WHERE Account.id = :ApexPages.currentPage().getParameters().get('Id')];
        
    }

}