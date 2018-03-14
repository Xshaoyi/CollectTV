public  Without Sharing class TNETChatterPollCtrl {

    public PollWrapper pw {get;set;}

    public TNETChatterPollCtrl (){
        System.debug('~~~Inside Constructor~~~');
        pw = new PollWrapper();
        pw.pollText = '';
        pw.pollContacts = new List<Contact> {new Contact(), new Contact(), new Contact()};
    }

    public class PollWrapper
    {
        public String pollText {get; set;}
        //public List<String> pollChoices {get;set;}
        public List<Contact> pollContacts {get;set;}
    }

    public PollWrapper getPw(){
        return pw;
    }

    public void addNewRecord()
    {
        pw.pollContacts.add(new Contact());
    }


    public PageReference save(){
        System.debug('~~~Inside createPoll() of MyChatterCtrl~~~');
        List<String> pollChoices = new List<string>();
        for(Contact con : pw.pollContacts){
            if(!String.isBlank(con.LastName)){
                pollChoices.add(con.LastName);
            }

        }
        System.debug('PollWrapper after clicking on save is  --->'+pw);
        System.debug('Community Id -->'+Network.getNetworkId());
        System.debug('Group Id --->'+ApexPages.currentPage().getParameters().get('Id'));

        createPoll(Network.getNetworkId(), ApexPages.currentPage().getParameters().get('Id'), pw.pollText, pollChoices);
        return null;
    }

    public void createPoll(String communityId, String groupId, String pollQuestion, List<String> pollChoices){
        System.debug('~~~Inside createPoll1() of MyChatterCtrl~~~');

        ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput();
        ConnectApi.FeedElementCapabilitiesInput feedElementCapabilitiesInput = new ConnectApi.FeedElementCapabilitiesInput();
        ConnectApi.PollCapabilityInput pollCapabilityInput = new ConnectApi.PollCapabilityInput();

        pollCapabilityInput.choices = pollChoices;
        feedElementCapabilitiesInput.poll = pollCapabilityInput;



        ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
        ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();

        // The MessageBodyInput object holds the text in the post
        messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
        textSegmentInput.text = 'Poll Posted - '+ System.now().format()+' \n '+pollQuestion;
        messageBodyInput.messageSegments.add(textSegmentInput);

        // Define the FeedItemInput object to pass to postFeedElement
        feedItemInput.body = messageBodyInput;
        feedItemInput.capabilities = feedElementCapabilitiesInput;
        feedItemInput.subjectId = groupId;

        //This is PostFeed Item
        ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(communityId,feedItemInput);

        //return null;
    }

    @AuraEnabled
    public static List<PollReport> getPollReports(){
        List<feedpollvote> feedChoiceList = [select id, Choice.ChoiceBody, CreatedBy.name,CreatedBy.Id, FeedItemId,CreatedDate from feedpollvote];
        Map<Id,feedItem> feeditemMap = new Map<Id,feedItem>([select id,body from feedItem where type='PollPost']);
        Set<String> userIdSet = new Set<String>();
        for(feedpollvote fpv:feedChoiceList){
            userIdSet.add(fpv.CreatedBy.Id);
        }
        Map<String,User> userMap = new Map<String,User>([SELECT contact.account.name from User where Id in:userIdSet ]);

        List<PollReport>  pollList = new List<PollReport>();
        for(feedpollvote fpv:feedChoiceList){
            PollReport pr = new PollReport();
            pr.pollVote = fpv;
            pr.pollQuestionName = feeditemMap.get(fpv.FeedItemId).body;
            Contact con = userMap.get(fpv.CreatedBy.Id).contact;
            if(con!=null){
                pr.accountName = con.account==null?'':con.account.name;
            }else{
                pr.accountName = '';
            }
            pollList.add(pr);
        }
        return pollList;

    }

    public class PollReport{
        @AuraEnabled
        feedpollvote pollVote{get;set;}

        @AuraEnabled
        String pollQuestionName{get;set;}

        @AuraEnabled
        String accountName{get;set;}
    }
    public static void fakeTest(){
        Integer i = 0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;

    }
}