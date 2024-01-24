/**
 * @description       : Classe abstrata para consumo de APIs
 * @author            : Leonardo de Oliveira (nowacki200@gmail.com)
 * @group             : 
 * @last modified on  : 2024-01-23
 * @last modified by  : Leonardo de Oliveira (nowacki200@gmail.com)
**/
//TODO: Criar interface para diminuir o acomplamento da classe de consumo de API
public abstract with sharing class API_cls {

    public class ResponseWrapper {
		public HttpResponse response;
		public Boolean success;
		public String message;

		public ResponseWrapper() {
			this.response = new HttpResponse();
			this.success = true;
			this.message = '';
		}
	}

	protected transient HttpRequest fReq;

	private static String fEndpointName;
	private static final Map< String, WebserviceConfiguration__mdt > fWebserviceConfigurationMap {
		get {
			if ( fWebserviceConfigurationMap <> null && fWebserviceConfigurationMap.containsKey( fEndpointName ) ) {
				return fWebserviceConfigurationMap;
			} 
            else {
				if ( fWebserviceConfigurationMap == null ) {
					fWebserviceConfigurationMap = new Map< String, WebserviceConfiguration__mdt >();
                }
                WebserviceConfiguration__mdt lWebserviceConfiguration = WebserviceConfiguration__mdt.getInstance( fEndpointName );
                fWebserviceConfigurationMap.put( fEndpointName, lWebserviceConfiguration );
				return fWebserviceConfigurationMap;
			}
		}
		set;
	}

	public API_cls( String aEndpointName ) {
		fEndpointName = aEndpointName;
		WebserviceConfiguration__mdt lWebserviceConfiguration = fWebserviceConfigurationMap.get( aEndpointName );
		if ( lWebserviceConfiguration <> null ) {
			this.fReq = this.getRequest( lWebserviceConfiguration.Method__c, lWebserviceConfiguration.Timeout__c, lWebserviceConfiguration.EndPoint__c );
		} 
        else {
			this.fReq = this.getRequest( 'GET', 120000, '' );
		}
	}

	public HttpRequest getRequest( String aMethod, Decimal aTimeout, String aEndpoint ) {
		HttpRequest lRequest = new HttpRequest();
		lRequest.setEndpoint( aEndpoint );
		lRequest.setMethod( aMethod );
		lRequest.setHeader( 'Content-Type', 'application/json;charset=UTF-8' );
		lRequest.setTimeout( Integer.valueOf( aTimeout ) );
		return lRequest;
	}

	public ResponseWrapper doRequest() {
		ResponseWrapper lRespWr = new ResponseWrapper();
		Http lHttp = new Http();
		try {
			this.fReq.setHeader( 'Authorization', '');
			lRespWr.response = lHttp.send( this.fReq );
			System.debug( LoggingLevel.INFO, 'Endpoint: ' + this.fReq.getEndpoint() );
			System.debug( LoggingLevel.INFO, 'Body: ' + this.fReq.getBody());
			System.debug( LoggingLevel.INFO, 'StatusCode: ' + lRespWr.response.getStatusCode());
			if ( lRespWr.response.getStatusCode() <> 200 && lRespWr.response.getStatusCode() <> 201 ) {
				lRespWr.success = false;
				lRespWr.message = lRespWr.response.getStatusCode() + '-' + lRespWr.response.getStatus() + '-' + lRespWr.response.getBody();
			}
		} 
        catch ( System.CalloutException error ) {
			lRespWr.success = false;
			lRespWr.message = error.getMessage();
		}
		return lRespWr;
	}
}