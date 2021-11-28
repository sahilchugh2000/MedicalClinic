import { LightningElement, wire } from "lwc";
import {
  subscribe,
  MessageContext
} from "lightning/messageService";
import SPECIALIZATION_CHANNEL from "@salesforce/messageChannel/Specialization__c";
import getPhysiciansbySpecialization from'@salesforce/apex/Utility.getPhysiciansbySpecialization';
import getCalenderList from'@salesforce/apex/CalenderActivitiesController.getCalenderList';
export default class PhysicianDetails extends LightningElement {
  @wire(MessageContext)
  messageContext;

  subscription = null;
  currentSpecialization;
  physicianList;
  mapData = [];

  columns = [{
    label: 'Physician name',
    fieldName: 'Name',
    type: 'text',
    sortable: true
  },
  {
    label: 'Email',
    fieldName: 'Email__c',
    type: 'text',
    sortable: true
  },
  {
    label: 'Summary',
    fieldName: 'Summary__c',
    type: 'text',
    sortable: true
  }
  ];

  calenderUrl;
  calenderId;
  summary;

  connectedCallback() {
    this.handleSubscribe();
}
handleSubscribe() {
  if (this.subscription) {
      return;
  }
  this.subscription = subscribe(this.messageContext, SPECIALIZATION_CHANNEL, (message) => {
    this.currentSpecialization = message.specializationName;
  });
}

  @wire(getPhysiciansbySpecialization,{name: '$currentSpecialization'})
  WiredgetPhysiciansbySpecialization({ error, data }) {
    if (data) {
      this.physicianList = data;
    } else if (error) {
        window.console.log(error);
    }
}

  @wire(getCalenderList)
  WiredgetCalenderList({ error, data }) {
    if (data) {
    this.mapData = data;
    } else if (error) {
        window.console.log(error);
    }
  }

getSelectedName(event) {
  const selectedRows = event.detail.selectedRows;
  if (event.detail != null && selectedRows != null || selectedRows != ''){
  if (selectedRows.length > 1){
    alert('Please select one Physican.');
  }
  else if (selectedRows.length == 1){
    for(var key in this.mapData){
      if (selectedRows[0].Summary__c != null && selectedRows[0].Summary__c != undefined && selectedRows[0].Summary__c == key){
        this.calenderUrl = "https://calendar.google.com/calendar/embed?src="  + this.mapData[key] ;
        this.calenderId = this.mapData[key];
        this.summary = key;

        return;
      }
      else{
        this.calenderUrl = null;
        this.calenderId = null;
      }
    }
  }
else{
  this.calenderUrl = null;
  this.calenderId = null;
}
}
}


}




