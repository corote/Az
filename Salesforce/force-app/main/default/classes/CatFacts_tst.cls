/**
 * @description       : Classe de teste responsável pelos cenários da classe CatFacts_ctr
 * @author            : Leonardo de Oliveira (nowacki200@gmail.com)
 * @group             : 
 * @last modified on  : 2024-01-24
 * @last modified by  : Leonardo de Oliveira (nowacki200@gmail.com)
**/
@isTest
public with sharing class CatFacts_tst {

    @isTest
    static void callWSFactTest() {
        WebserviceConfiguration__mdt lWebServiceConf = WebserviceConfiguration__mdt.getInstance( 'CatFact' );
        
        List< Object > lParameters = new List< Object > { '255' };
        String lEndpoint = String.format( lWebServiceConf.EndPoint__c, lParameters );

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource( lEndpoint, 'CatFactResponseBodyJSON' );
        multimock.setStatusCode( 200 );

        Test.setMock( HttpCalloutMock.class, multimock );
        Test.startTest();
            String lReturn = CatFacts_ctr.callWSFact();
        Test.stopTest();
        System.assert( String.isNotBlank( lReturn ) );
    }

    @isTest
    static void getFactErrorTest() {
        WebserviceConfiguration__mdt lWebServiceConf = WebserviceConfiguration__mdt.getInstance( 'CatFact' );
        
        List< Object > lParameters = new List< Object > { '255' };
        String lEndpoint = String.format( lWebServiceConf.EndPoint__c, lParameters );

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource( lEndpoint, 'CatFactResponseBodyJSON' );
        multimock.setStatusCode( 404 );

        Test.setMock( HttpCalloutMock.class, multimock );
        Test.startTest();
            try {
                String lReturn = CatFacts_ctr.callWSFact();
            } 
            catch ( Exception error ) {
                System.assert( error.getMessage().contains( 'Attempt to de-reference a null object' ), error.getMessage() );
            }
        Test.stopTest();
    }
}