trigger findContactForCase on Case (before insert) {
    Contact cont=[select id from contact where email=:trigger.new[0].EmailTest__c];
    if(cont==null)
        system.debug('no contact found');
    else{        
        system.debug('contact found');

        trigger.new[0].contactid=cont.id;
        trigger.new[0].SuppliedCompany='test';
        }
}