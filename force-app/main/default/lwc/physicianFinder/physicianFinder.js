import { LightningElement, wire } from 'lwc';
import getSpecializations from'@salesforce/apex/Utility.getSpecializations';
import { publish, MessageContext } from "lightning/messageService";
import SPECIALIZATION_CHANNEL from "@salesforce/messageChannel/Specialization__c";

export default class PhysicianFinder extends LightningElement {
  value = 'General Practice'; // To do , create labels
  specializationPicklist;
  price;
  mapData = [];

  @wire(MessageContext)
  messageContext;

  @wire(getSpecializations)
  WiredgetSpecializations({ error, data }) {
    if (data) {
      let options = [];
      this.mapData = data;
      for(var key in data){
        if (this.value == data[key].Name){
          this.price = data[key].Price__c;
    }
        options.push({value:data[key].Name, label:data[key].Name}); // creating an array to show on the UI.
    }
    this.specializationPicklist = options;
    //Publishing the message
    publish(this.messageContext, SPECIALIZATION_CHANNEL, {specializationName: this.value});

    } else if (error) {
        window.console.log(error);
    }
}
  handleChange(event) {
    this.value = event.detail.value;
    for(var key in this.mapData){
      if (this.value == this.mapData[key].Name){
        this.price = this.mapData[key].Price__c;
      }
    }
    //Publishing the message
    publish(this.messageContext, SPECIALIZATION_CHANNEL, {specializationName: this.value});
  }
}
