/**
 * @description       : Classe de teste responsável pelos cenários da classe RelatedOpportunities_ctr
 * @author            : Leonardo de Oliveira (nowacki200@gmail.com)
 * @group             : 
 * @last modified on  : 2024-01-24
 * @last modified by  : Leonardo de Oliveira (nowacki200@gmail.com)
**/
@isTest
public with sharing class RelatedOpportunities_tst {

    @isTest
    static void getOpportunitiesTest() {
        Account lAccount = (Account) new AccountFactory_tst.AccountFactory().createRecord();
        Test.startTest();
            Opportunity[] lReturn = RelatedOpportunities_ctr.getOpportunities( lAccount.Id );
        Test.stopTest();
        System.assertEquals( 2, lReturn.size() );
    }
}