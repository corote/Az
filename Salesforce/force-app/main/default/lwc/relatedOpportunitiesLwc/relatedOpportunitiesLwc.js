import { LightningElement, api, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getOpportunities from '@salesforce/apex/RelatedOpportunities_ctr.getOpportunities';

const columns = [
    { label: 'Nome da oportunidade', fieldName: 'id_link', type: 'url', typeAttributes: { label: { fieldName: 'name' }, target: '_self' }, hideDefaultActions: true },
    { label: 'Data de Fechamento', fieldName: 'closeDate', type: 'date', typeAttributes:{ year: "numeric", month: "2-digit", day: "2-digit", }, cellAttributes: { alignment: 'left' }, hideDefaultActions: true },
    { label: 'Valor', fieldName: 'amount', type: 'currency', cellAttributes: { alignment: 'left' }, hideDefaultActions: true },
];

export default class RelatedOpportunitiesLwc extends NavigationMixin(LightningElement) {
    @api recordId;

    columns = columns;
    data = [];
    showFooter = false;
    size = '0';

    connectedCallback() {
        this.fetchData();
    }

    fetchData() {
        getOpportunities({ 'aRecordId' : this.recordId })
        .then( result => { 
            this.formatResult( result );
            this.showFooter = ( result.length > 0 );
            this.size = ( result.length == 6 )? '6+' : result.length.toString();
        })
        .catch( error => {
            this.showToast( error );
        });
    }

    formatResult(result) {
        result.forEach(element => {
            this.data.push (Object.assign({
                'id': element.Id,
                'name': element.Name,
                'closeDate': element.CloseDate,
                'amount': element.Amount,
                'id_link': '/lightning/r/Opportunity/' + element.Id + '/view'
            }));
        });
    }

    handleClick() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: 'Account',
                relationshipApiName: 'Opportunities',
                actionName: 'view'
            },
        });
    }

    showToast( error ) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Ocorreu um erro inesperado, contate um Administrador do Sistema',
                message: error.body.message,
                variant: 'error'
            })
        );
    }
}