/**
 * @description       : Classe Handler do objeto Account
 * @author            : Leonardo de Oliveira (nowacki200@gmail.com)
 * @group             : 
 * @last modified on  : 2024-01-23
 * @last modified by  : Leonardo de Oliveira (nowacki200@gmail.com)
**/
public with sharing class AccountHandler_cls {

    public static void createOpportunity( Account[] aNewAccountLst ) {
        Opportunity[] lOpportunityLst = new List< Opportunity >();
        for( Account aAccount : aNewAccountLst ) {
            lOpportunityLst.addAll( getOpportunityLst( aAccount.Id ) );
        }
        if( lOpportunityLst.isEmpty() ) { return; }

        Database.SaveResult[] srLst = Database.insert( lOpportunityLst, false );
		for( Database.SaveResult sr : srLst ) {
			if( !sr.isSuccess() ) {
				System.debug( sr.getErrors().get( 0 ).getMessage() );
			}
		}
    }

    public static Opportunity[] getOpportunityLst( Id aAccountId ) {
        Opportunity lOpportunity1 = new Opportunity(
            Name = Label.Opportunity1,
            StageName = 'Prospect',
            CloseDate = System.today(),
            Amount = 2000,
            AccountId = aAccountId
        );
        Opportunity lOpportunity2 = new Opportunity(
            Name = Label.Opportunity2,
            StageName = 'Prospect',
            CloseDate = System.today().addDays( 30 ),
            Amount = 1000,
            AccountId = aAccountId
        );
        return new List< Opportunity > { lOpportunity1, lOpportunity2 };
    }
}