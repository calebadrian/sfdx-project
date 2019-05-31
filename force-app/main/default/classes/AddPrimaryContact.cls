public with sharing class AddPrimaryContact implements Queueable {

    private Contact toAdd;
    private String state;

    public AddPrimaryContact(Contact toAdd, String state){
        this.toAdd = toAdd;
        this.state = state;
    }

    public void execute(QueueableContext context){
        List <Account> allAccounts = [SELECT Id FROM Account WHERE BillingState = :state];
        List <Contact> allContacts = new List <Contact>();
        for (Account ac : allAccounts){
            Contact newContact = toAdd.clone();
            newContact.AccountId = ac.Id;
            allContacts.add(newContact);
        }
        insert allContacts;
    }
}