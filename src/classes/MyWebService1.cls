global class MyWebService1 {
        webService static Id makeContact(String lastName, Account a) {
        Contact c = new Contact(lastName = 'Smith', AccountId = a.Id);
        insert c;
        return c.id;
        }
}