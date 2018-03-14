({
	doInit : function(component, event, helper) {
    	// Retrieve contacts during component initialization
    	helper.getContacts(component);
    },//Delimiter for future code
    myclick :function(cmp, event, helper) {
        var obj=cmp.find('mydiv');
        $A.util.addClass(obj,'move');
    }
})