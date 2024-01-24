/**
 * @description       : Factory de Account para classes de teste
 * @author            : Leonardo de Oliveira (nowacki200@gmail.com)
 * @group             : 
 * @last modified on  : 2024-01-24
 * @last modified by  : Leonardo de Oliveira (nowacki200@gmail.com)
**/
@isTest
public class AccountFactory_tst {

    private static Map< String, Account > fStaticRecord = new Map< String, Account >();

    public static Account createAccount() {
		String lAccountNumber = 'AA123456';
		if( !fStaticRecord.containsKey( lAccountNumber ) ) {
			fStaticRecord.put(
				lAccountNumber,
				new Account(
                    Name = 'Factory',
                    AccountNumber = lAccountNumber
                )
			);
		}
		return fStaticRecord.get( lAccountNumber );
	}

    public class AccountFactory extends SObjectFactory_cls {
		public AccountFactory() {
			super( createAccount() );
		}
	}
}