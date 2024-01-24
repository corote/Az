/**
 * @description       : Classe de teste responsável pelos cenários da classe AccountHandler
 * @author            : Leonardo de Oliveira (nowacki200@gmail.com)
 * @group             : 
 * @last modified on  : 2024-01-24
 * @last modified by  : Leonardo de Oliveira (nowacki200@gmail.com)
**/
@isTest
public with sharing class AccountHandler_tst {

    @isTest
    static void createOpportunityTest() {
        Test.startTest();
            Account lAccount = (Account) new AccountFactory_tst.AccountFactory().createRecord();
        Test.stopTest();
        Opportunity[] lOpportunityLst = [SELECT Id FROM Opportunity WHERE AccountId =: lAccount.Id];
        System.assertEquals( 2, lOpportunityLst.size() );
    }
}