import { LightningElement } from 'lwc';
import createTrustedSite from '@salesforce/apex/CspTrustedSiteCreator.createTrustedSite';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CspTrustedSiteForm extends LightningElement {
    siteName = '';
    siteUrl = '';
    isLoading = false;

    handleNameChange(event) {
        this.siteName = event.target.value;
    }

    handleUrlChange(event) {
        this.siteUrl = event.target.value;
    }

    handleCreate() {
        if (!this.siteName || !this.siteUrl) {
            this.showToast('Error', 'Please fill in all fields', 'error');
            return;
        }

        this.isLoading = true;
        createTrustedSite({ siteUrl: this.siteUrl, siteName: this.siteName })
            .then(() => {
                this.showToast('Success', 'Trusted Site created successfully', 'success');
                this.siteName = '';
                this.siteUrl = '';
            })
            .catch(error => {
                let message = 'Unknown error';
                if (Array.isArray(error.body)) {
                    message = error.body.map(e => e.message).join(', ');
                } else if (typeof error.body.message === 'string') {
                    message = error.body.message;
                }
                this.showToast('Error', 'Error creating site: ' + message, 'error');
                console.error('Error creating site:', error);
            })
            .finally(() => {
                this.isLoading = false;
            });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}
