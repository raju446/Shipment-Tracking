import { LightningElement, api, wire } from 'lwc';
import getShipmentDetails from '@salesforce/apex/Case_ShipmentStatusController.getShipmentDetails';
import { getRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

// Define the fields that will be retrieved from the record
const FIELDS = ["Case.Shipment_Tracking_Number__c"];

export default class CaseShipmentStatus extends LightningElement {
    // Private properties for shipment info and error handling
    _ShipmentInfo; 
    error;
    @api recordId; // Public property to hold the record ID
    _class = ''; // Class for styling the message box

    /**
     * Wire service to retrieve record details based on the recordId
     * @param {Object} data - The data object containing record fields
     * @param {Object} error - The error object if an error occurs
     */
    @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
    wiredRecord({ error, data }) {
        if (error) {
            // Handle any errors that occur during record retrieval
            this.handleError(error);
        } else if (data) {
            // Call handleLoad method with the shipment tracking number from the record
            this.handleLoad(data.fields.Shipment_Tracking_Number__c.value);
        }
    }
    
    /**
     * Fetch shipment details from the server based on the tracking number
     * @param {string} trackNumber - The shipment tracking number
     */
    async handleLoad(trackNumber) {
        try {
            console.log(trackNumber, "trackNumber"); // Log the tracking number for debugging
            // Call Apex method to get shipment details
            var res = await getShipmentDetails({ 'trackNumber': trackNumber });
            var obj = JSON.parse(JSON.stringify(res));

            // Clean up the message by removing unwanted characters
            var cleanedMessage = obj.message.replace(/\\|"/g, '');

            // Check for errors or specific messages and set class and shipment info accordingly
            if (obj.hasError || cleanedMessage == 'Error - Must provide tracking number') {
                this._ShipmentInfo = cleanedMessage;
                this._class = 'slds-box slds-theme_error'; // Set error styling class
            } else {
                this._ShipmentInfo = cleanedMessage;
                this._class = 'slds-box slds-theme_success'; // Set success styling class
            }

            this.error = undefined; // Clear error if successful
        } catch (error) {
            // Handle any errors that occur during shipment details retrieval
            this._ShipmentInfo = undefined;
            this.handleError(error);
        }
    }

    /**
     * Handle errors by displaying a toast message with error details.
     * @param {Object} error - Error object containing details about the error
     */
    handleError(error) {
        let message = "Unknown error"; // Default error message
        if (Array.isArray(error.body)) {
            // If the error body contains an array of messages, join them into a single string
            message = error.body.map((e) => e.message).join(", ");
        } else if (typeof error.body.message === "string") {
            // If the error body contains a single message, use it directly
            message = error.body.message;
        }
        // Dispatch a toast event to display the error message
        this.dispatchEvent(
            new ShowToastEvent({
                title: "Error",
                message,
                variant: "error", // Variant for error styling
            })
        );
    }
}