/*
Author: Nishant Mohan Wavhal
Lightning Web Component for Product Info Client
*/

import { LightningElement,api,wire} from 'lwc';
import getCostPerService from '@salesforce/apex/ProductInfoController.getServices';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ProductInfoClient extends LightningElement{

@api recordId;

homecountry;
product;
cost_calmonth;
cardreplace_cost;
atm_fee;
isocode;
error;

@wire(getCostPerService, { caseId: '$recordId' })
    wiredServices({ error, data }) {
        if (data) {
            this.homecountry = data.homecountry;
            this.product=data.product;
            this.cost_calmonth=data.psubscriptioncost.Monthly_Charges__c;
            this.atm_fee=data.psubscriptioncost.ATM_Fee__c;
            this.cardreplace_cost=data.psubscriptioncost.Card_Replacement_Cost__c;
            this.isocode=data.isocode;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent
                ({
                    title: "Error",
                    message:this.error.body.message,
                    variant: "Error",
               }),
              );    
              this.homecountry = undefined;
              this.product=undefined;
              this.cost_calmonth=undefined;
              this.atm_fee=undefined;
              this.isocode=undefined;
              this.cardreplace_cost=undefined;
        }
    }
}