/**
 * @description       : Classe controller do componente catFactsLwc
 * @author            : Leonardo de Oliveira (nowacki200@gmail.com)
 * @group             : 
 * @last modified on  : 2024-01-23
 * @last modified by  : Leonardo de Oliveira (nowacki200@gmail.com)
**/
public with sharing class CatFacts_ctr {
    
    @AuraEnabled
    public static String callWSFact() {
        CatFacts_ws lWebService = new CatFacts_ws();
        CatFacts_ws.CatFactWrapper lReturn = lWebService.getFact();
        return lReturn.fact;
    }
}