public class TNETSearchResultsCtrl {
    
    @AuraEnabled
    public static SearchResultWrapper search(String keywords){
        System.debug(LoggingLevel.INFO, '*** keywords: ' + keywords);
        SearchResultWrapper srw = new SearchResultWrapper();
        Date today = System.today();

        if (String.isNotBlank(keywords)) {
            keywords = EncodingUtil.urlDecode(keywords, 'utf-8');
            keywords += '*';
            String sosl = 'FIND \'' + keywords + '\' IN ALL FIELDS '
                        + 'RETURNING '
                        + 'Document(Name, Type, Description WHERE FolderId = \''+Label.TNET_Document_Folder_Id+'\'),'
                        + 'ContentVersion(Id,Title, FileType, Description,ContentDocumentID WHERE IsLatest=true AND TITLE LIKE \'Community%\')'
                        ;//+ 'ContentDocument(Title, FileType, Description)'
            System.debug(LoggingLevel.INFO, '*** sosl: ' + sosl);

            List<List<SObject>> searchResults = Search.query(sosl);

            srw.documents = (List<Document>)searchResults[0];
            srw.files     = (List<ContentVersion>)searchResults[1]; //00l4D000000DgRI
        }
        System.debug(LoggingLevel.INFO, '*** srw: ' + srw);
        return srw;
      }

    public class SearchResultWrapper {
        @AuraEnabled
        public List<Document> documents {get; set;}

        @AuraEnabled
        public List<ContentVersion> files {get; set;}
    }
}