# Case Shipment Status Lightning Web Component

This Salesforce Lightning Web Component (LWC) is designed to retrieve and display the latest status of a shipment based on the tracking number from a Case record. The component uses an Apex controller to fetch shipment details from an external service.

## Overview

- **Apex Controller**: `Case_ShipmentStatusController`
  - Fetches shipment details from an external service using the tracking number.
- **Lightning Web Component**: `CaseShipmentStatus`
  - Displays shipment information based on the tracking number retrieved from the Case record.

## Features

- Retrieves shipment status from an external service.
- Displays status information with appropriate styling for errors or successful retrieval.
- Handles errors and displays user-friendly messages.

## Prerequisites

- Salesforce org with API access.
- Access to the external service endpoint for shipment status.

## Setup Instructions

### 1. Apex Controller

1. Go to Salesforce Setup.
2. Navigate to `Apex Classes` and click `New`.
3. Copy and paste the `Case_ShipmentStatusController` class into the editor and save it.

### 2. Lightning Web Component

1. Open the Salesforce Developer Console or use Salesforce CLI to create a new Lightning Web Component.
2. Create a new component named `caseShipmentStatus`.
3. Replace the default code with the provided `CaseShipmentStatus` JavaScript code.

### 3. External Service

Ensure that the external service endpoint is correctly configured and accessible. Update the endpoint URL in the `Case_ShipmentStatusController` if necessary.

## Usage

1. Add the `caseShipmentStatus` component to a Lightning Record Page for the Case object.
2. Ensure that the Case record contains a valid shipment tracking number in the `Shipment_Tracking_Number__c` field.
3. The component will automatically fetch and display the shipment status based on the tracking number.

## Error Handling

- If the shipment tracking number is missing or invalid, the component will display an error message.
- Any errors during the retrieval process will be shown as toast notifications.
