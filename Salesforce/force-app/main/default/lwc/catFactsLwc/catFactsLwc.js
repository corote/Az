import { LightningElement } from 'lwc';
import callWSFact from '@salesforce/apex/CatFacts_ctr.callWSFact';

export default class CatFactsLwc extends LightningElement {

    disable = true;
    fact = 'Fact';

    connectedCallback() {
        this.callFact();
    }

    handleClick() {
        this.disable = true;
        this.callFact();
    }

    callFact() {
        callWSFact()
        .then( result => {
            this.fact = result;
            this.disable = false;
        })
        .catch( error => {
            this.showToast( error );
            this.disable = false;
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