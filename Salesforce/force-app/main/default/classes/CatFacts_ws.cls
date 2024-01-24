/**
 * @description       : Classe Web Service para consumo da API Cat Facts
 * @author            : Leonardo de Oliveira (nowacki200@gmail.com)
 * @group             : 
 * @last modified on  : 2024-01-23
 * @last modified by  : Leonardo de Oliveira (nowacki200@gmail.com)
**/
public with sharing class CatFacts_ws extends API_cls {

    public class CatFactWrapper {
        public String fact;
        public Integer length;
    }

    public static final String ENDPOINT = 'CatFact';

    public CatFacts_ws() {
        super( ENDPOINT );
    }

    public CatFactWrapper getFact() {
        String lEndpoint = this.fReq.getEndpoint();
        List< Object > lParameters = new List< Object > { '255' };
        this.fReq.setEndpoint( String.format( lEndpoint, lParameters ) );
        API_cls.ResponseWrapper lResult = this.doRequest();
        if( lResult.success ) {
            return (CatFactWrapper) System.JSON.deserialize( lResult.response.getBody(), CatFactWrapper.class );
        }
        return null;
    }
}