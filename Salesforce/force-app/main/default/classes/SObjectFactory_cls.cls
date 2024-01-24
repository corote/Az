/**
 * @description       : test only data factory class
 * @author            : Leonardo de Oliveira (nowacki200@gmail.com)
 * @group             : 
 * @last modified on  : 2024-01-24
 * @last modified by  : Leonardo de Oliveira (nowacki200@gmail.com)
**/
public abstract class SObjectFactory_cls {

	public String FIELD_INTERATOR = 'Description';
    public Integer DEFAULT_BULK_RECORDS = 20; // 20 is the minimum amount recommended by Salesforce
	public List< SObject > LIST_SOBJECT_FIELD_INTERATOR; // if null use only FIELD_INTERATOR, else use Id of this list + FIELD_INTERATOR
	
	private SObject fRecord {get;set;}
	private List< SObject > fRecordLst {get;set;}

	public SObjectFactory_cls( SObject aRecord ) {
		fRecord = aRecord;
	}

	public SObjectFactory_cls( List< SObject > aRecordLst ) {
		fRecordLst = aRecordLst;
	}

	public void setRecord( SObject aRecord ) {
		fRecord = aRecord;
	}

	public SObject getRecord() {
		return fRecord;
	}

	public SObject cloneRecord() {
		return fRecord.clone();
	}

	public virtual SObject createRecord() {
		if( fRecord.Id == null ) {
			insert fRecord;
		}
		return fRecord;
	}

	public List< SObject > getRecords() {
		if( fRecordLst == null ) {
			fRecordLst = new List< SObject >();
			for( Integer i = 0; i < DEFAULT_BULK_RECORDS; i++ ) {
				SObject fRecordCloned = fRecord.clone();
				if( LIST_SOBJECT_FIELD_INTERATOR == null ) {
					fRecordCloned.put( FIELD_INTERATOR, fRecord.get( FIELD_INTERATOR ) + ' ' + i );
				}
				else {
					fRecordCloned.put( FIELD_INTERATOR, LIST_SOBJECT_FIELD_INTERATOR.get( i ).Id) ;
					fRecordLst.add( fRecordCloned );
				}
			}
		}
		return fRecordLst;
	}

	public List< SObject > createRecords() {
		fRecordLst = getRecords();
		if( !fRecordLst.isEmpty() && fRecordLst.get( 0 ).Id == null ) {
			insert fRecordLst;
		}
		return fRecordLst;
	}
}