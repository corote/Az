/**
 * @description       : Trigger do objeto Account
 * @author            : Leonardo de Oliveira (nowacki200@gmail.com)
 * @group             : 
 * @last modified on  : 2024-01-23
 * @last modified by  : Leonardo de Oliveira (nowacki200@gmail.com)
**/
trigger Account_trg on Account ( before insert, before update, before delete, after insert, after update ) {
    TriggerConfiguration__mdt lAccountTrigger = TriggerConfiguration__mdt.getInstance( 'Account' );
    if( !lAccountTrigger.IsActive__c ) { return; }

    if( Trigger.isBefore ) {
        if( Trigger.isInsert ) {}
        if( Trigger.isUpdate ) {}
        if( Trigger.isDelete ) {}
    }

    if( Trigger.isAfter ) {
        if( Trigger.isInsert ) {
            AccountHandler_cls.createOpportunity( Trigger.new );
        }
        if( Trigger.isUpdate ) {}
    }
}