import { LightningElement, track } from 'lwc';
import deployMetadata from '@salesforce/apex/SetupAssistantController.deployMetadata';

export default class SetupAssistant extends LightningElement {
    @track isLoading = false;
    @track isSuccess = false;
    @track error;

    handleDeploy() {
        this.isLoading = true;
        this.error = null;
        this.isSuccess = false;

        deployMetadata()
            .then(result => {
                this.isSuccess = true;
            })
            .catch(error => {
                this.error = error.body ? error.body.message : error.message;
            })
            .finally(() => {
                this.isLoading = false;
            });
    }
}
