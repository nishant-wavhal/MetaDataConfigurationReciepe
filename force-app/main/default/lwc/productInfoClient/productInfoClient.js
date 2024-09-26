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
costpermonth;
cardreplacementcost;
atmfee;
isocode;
error;

@wire(getCostPerService, { caseId: '$recordId' })
    wiredServices({ error, data }) {
        if (data) {
            this.homecountry = data.homecountry;
            this.product=data.product;
            this.costpermonth=data.productsubscription.Monthly_Charges__c;
            this.atmfee=data.productsubscription.ATM_Fee__c;
            this.cardreplacementcost=data.productsubscription.Card_Replacement_Cost__c;
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
              this.costpermonth=undefined;
              this.atmfee=undefined;
              this.isocode=undefined;
              this.cardreplacementcost=undefined;
        }
    }
}