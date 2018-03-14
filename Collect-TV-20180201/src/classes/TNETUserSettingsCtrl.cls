/**
 * Created by sankur001 on 6/1/2017.
 */

public with sharing class TNETUserSettingsCtrl {

    @AuraEnabled
    public static NetworkMember getUserDetails(){

        List<NetworkMember> nwmList = [SELECT Id,MemberId,DefaultGroupNotificationFrequency, PreferencesDisableAllFeedsEmail,PreferencesDisableBookmarkEmail,
                PreferencesDisableChangeCommentEmail,PreferencesDisableFollowersEmail,PreferencesDisableLaterCommentEmail,
                PreferencesDisableLikeEmail,PreferencesDisableMentionsPostEmail,PreferencesDisablePendingReviewEmail,
                PreferencesDisCommentAfterLikeEmail,PreferencesDisMentionsCommentEmail,PreferencesDisProfPostCommentEmail
                FROM NetworkMember
                WHERE MemberId=: Userinfo.getUserid()];

        NetworkMember nm = nwmList[0];
        NetworkMember nmd = new NetworkMember();
        nmd.Id = nm.Id;
        nmd.PreferencesDisableAllFeedsEmail = !nm.PreferencesDisableAllFeedsEmail;
        nmd.PreferencesDisableBookmarkEmail = !nm.PreferencesDisableBookmarkEmail;
        nmd.PreferencesDisableChangeCommentEmail = !nm.PreferencesDisableChangeCommentEmail;
        nmd.PreferencesDisableFollowersEmail = !nm.PreferencesDisableFollowersEmail;
        nmd.PreferencesDisableLaterCommentEmail = !nm.PreferencesDisableLaterCommentEmail;
        nmd.PreferencesDisableLikeEmail = !nm.PreferencesDisableLikeEmail;
        nmd.PreferencesDisableMentionsPostEmail = !nm.PreferencesDisableMentionsPostEmail;
        nmd.PreferencesDisablePendingReviewEmail = !nm.PreferencesDisablePendingReviewEmail;
        nmd.PreferencesDisCommentAfterLikeEmail = !nm.PreferencesDisCommentAfterLikeEmail;
        nmd.PreferencesDisMentionsCommentEmail = !nm.PreferencesDisMentionsCommentEmail;
        nmd.PreferencesDisProfPostCommentEmail = !nm.PreferencesDisProfPostCommentEmail;
        return nmd;
    }

    @AuraEnabled
    public static void saveDetails (NetworkMember nm) {

        NetworkMember nmd = new NetworkMember();
        nmd.Id = nm.Id;
        nmd.PreferencesDisableAllFeedsEmail = !nm.PreferencesDisableAllFeedsEmail;
        nmd.PreferencesDisableBookmarkEmail = !nm.PreferencesDisableBookmarkEmail;
        nmd.PreferencesDisableChangeCommentEmail = !nm.PreferencesDisableChangeCommentEmail;
        nmd.PreferencesDisableFollowersEmail = !nm.PreferencesDisableFollowersEmail;
        nmd.PreferencesDisableLaterCommentEmail = !nm.PreferencesDisableLaterCommentEmail;
        nmd.PreferencesDisableLikeEmail = !nm.PreferencesDisableLikeEmail;
        nmd.PreferencesDisableMentionsPostEmail = !nm.PreferencesDisableMentionsPostEmail;
        nmd.PreferencesDisablePendingReviewEmail = !nm.PreferencesDisablePendingReviewEmail;
        nmd.PreferencesDisCommentAfterLikeEmail = !nm.PreferencesDisCommentAfterLikeEmail;
        nmd.PreferencesDisMentionsCommentEmail = !nm.PreferencesDisMentionsCommentEmail;
        nmd.PreferencesDisProfPostCommentEmail = !nm.PreferencesDisProfPostCommentEmail;

        update nmd;

    }

}