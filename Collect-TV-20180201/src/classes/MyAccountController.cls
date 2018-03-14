public with sharing class MyAccountController {
	private String  mode='view';
	private Boolean sortOrder=false;
	private Id myid;
	public void setMyid(Id i){
		myid=i;
	}
	public ID getMyid(){
		return myid;
	}
    public MyAccountController() {
    }
    private List<Account> accounts;
    public List<Account> getAccounts(){
    	String ListOrder;
    	if(sortOrder==false)
    		ListOrder='ASC';
    	else
    		ListOrder='desc';
    	return Database.query('select Name,Phone,type,Owner.Alias from Account order by Name '+ListOrder);
    }
    private Account account;
    public void setAccount(Account a){
    	account=a;
    }
    public Account getAccount(){
    	return account;
    }
   
    public PageReference save() {
		update account;
		mode='view';
		return null;
	}
	public PageReference cancle() {
		mode='view';
		return null;
	}
	public  String getMode(){
		return mode;
	}
	public  Boolean getSortOrder(){
		return sortOrder;
	}
	public  void  setMode(String m){
		mode=m;
	}
	public PageReference changeToEdit(){
		System.debug('nihao');
		System.debug(myid);
		Id tempid=Apexpages.currentPage().getParameters().get('firstParam');
		System.debug('t'+tempid);
		for(Account ac:getAccounts()){
			if(ac.Id.equals(myid)){
				setAccount(ac);
			}
		}
		mode='edit';
		return null;
	}
	public void deleteRecord(){
		Id tempid=Apexpages.currentPage().getParameters().get('firstParam');
		for(Account ac:getAccounts()){
			if(ac.Id.equals(myid)){
				delete ac;
			}
		}
	}
	public void SortByName(){
		sortOrder=!sortOrder;
	}
}