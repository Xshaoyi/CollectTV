({
	myclick : function(cmp, event, helper) {
		var a=cmp.get("v.edit");
        if(a){
            cmp.set("v.edit",false);
        }else
            cmp.set("v.edit",true);
	}
})