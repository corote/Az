/**
 * @description       : Classe Controller responsável pelo componente RelatedOpportunitiesLwc
 * @author            : Leonardo de Oliveira (nowacki200@gmail.com)
 * @group             : 
 * @last modified on  : 2024-01-23
 * @last modified by  : Leonardo de Oliveira (nowacki200@gmail.com)
**/
public with sharing class RelatedOpportunities_ctr {
    
    @AuraEnabled
    public static Opportunity[] getOpportunities( String aRecordId ) {
        return [SELECT Id, Name, CloseDate, Amount FROM Opportunity WHERE AccountId = :aRecordId ORDER BY CloseDate DESC LIMIT 6];
    }
}