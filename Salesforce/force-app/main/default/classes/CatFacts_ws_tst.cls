/**
 * @description       : Classe de teste responsável pelos cenários da classe CatFacts_ws
 * @author            : Leonardo de Oliveira (nowacki200@gmail.com)
 * @group             : 
 * @last modified on  : 2024-01-24
 * @last modified by  : Leonardo de Oliveira (nowacki200@gmail.com)
**/
@isTest
public with sharing class CatFacts_ws_tst {

    @isTest
    static void getFactTest() {
        WebserviceConfiguration__mdt lWebServiceConf = WebserviceConfiguration__mdt.getInstance( 'CatFact' );
        
        List< Object > lParameters = new List< Object > { '255' };
        String lEndpoint = String.format( lWebServiceConf.EndPoint__c, lParameters );

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource( lEndpoint, 'CatFactResponseBodyJSON' );
        multimock.setStatusCode( 200 );

        Test.setMock( HttpCalloutMock.class, multimock );
        Test.startTest();
            CatFacts_ws lWebService = new CatFacts_ws();
            CatFacts_ws.CatFactWrapper lReturn = lWebService.getFact();
        Test.stopTest();
        System.assert( lReturn <> null );
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
            CatFacts_ws lWebService = new CatFacts_ws();
            CatFacts_ws.CatFactWrapper lReturn = lWebService.getFact();
        Test.stopTest();
        System.assert( lReturn == null );
    }
}