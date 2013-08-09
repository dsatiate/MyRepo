trigger RemoveDuplicate on Contact (before insert, before update) {
    
    Set<String> contactEmail = new Set<String>();
    set<String> CrossCheck_contact_Email= new Set<String>();
    set<String> CrossCheck_lead_Email= new Set<String>();
    set<String> CrossCheck_user_Email= new Set<String>();

    for (Contact c : Trigger.new){
    if(contactEmail.contains(c.Email)){
        c.addError('Duplicate Email found in this batch');
    }
        else{
        contactEmail.add(c.Email);
    }
    }
    
   list<Contact> LOE1 = new   list<Contact>([select  email from Contact
                    where Email in :contactEmail ]);
   list<lead> LOE2 = new   list<lead>([select  email from lead
                    where Email in :contactEmail ]);
   list<user> LOE3 = new   list<user>([select  email from user
                    where Email in :contactEmail ]); 

                                                                       
   for(Contact c : LOE1 ){ 
        CrossCheck_contact_Email.add(c.Email);
    }               
   for(lead l : LOE2 ){ 
        CrossCheck_lead_Email.add(l.Email);
    } 
   for(user u : LOE3 ){ 
        CrossCheck_user_Email.add(u.Email);
    } 

    
   for (Contact c : Trigger.new){
        if(CrossCheck_contact_Email.contains(c.Email))
        {
            c.addError('Duplicate Email found in Contact');
        }

        if(CrossCheck_lead_Email.contains(c.Email))
        {
            c.addError('Duplicate Email found in lead');
        }
        
        if(CrossCheck_user_Email.contains(c.Email))
        {
            c.addError('Duplicate Email found in user');
        }
   }
    
}