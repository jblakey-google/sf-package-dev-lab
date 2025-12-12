import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import MY_TEST_CHANNEL from '@salesforce/messageChannel/MyTestChannel__c';

export default class MessageSender extends LightningElement {
    @wire(MessageContext)
    messageContext;

    handlePostMessage() {
        // Post a message to the window
        const payload = {
            source: 'messageSender',
            message: 'Hello from window.postMessage',
            timestamp: new Date().toISOString()
        };
        window.postMessage(payload, '*');
        console.log('messageSender sent window message');
    }

    handleLMSMessage() {
        const payload = {
            source: 'messageSender',
            message: 'Hello from LMS',
            timestamp: new Date().toISOString()
        };
        publish(this.messageContext, MY_TEST_CHANNEL, payload);
        console.log('messageSender sent LMS message');
    }
}
