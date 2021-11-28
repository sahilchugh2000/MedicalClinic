import { LightningElement,api } from 'lwc';
import createCalenderEvent from'@salesforce/apex/CalenderActivitiesController.createCalenderEvent';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class BookAppointment extends LightningElement {
  @api patientEmail;
  @api apptDatetime;
  @api calenderId;
  @api summary;

  handledChange(event){
    if(event.target.name==='patientEmail'){
        this.patientEmail = event.target.value;
    }
    else if(event.target.name==='apptDatetime'){
       this.apptDatetime = event.target.value;
    }
  }

handleClick(){

  if (this.patientEmail == '' || this.patientEmail == null || this.apptDatetime == null || this.apptDatetime == ''){
      alert('Please provide Patient Email and Apppointment Date and time');
  }
  else{
  createCalenderEvent({
      email : this.patientEmail,
      apptTime : this.apptDatetime,
      calenderId : this.calenderId,
      summary : this.summary
  })
  .then(result => {
      const event = new ShowToastEvent({
          title: 'Event created',
          message: 'Appointment  created.',
          variant: 'success'
      });
      this.dispatchEvent(event);
  })
  .catch(error => {
      const event = new ShowToastEvent({
          title : 'Error',
          message : 'Error creating Event. Please Contact System Admin',
          variant : 'error'
      });
      this.dispatchEvent(event);
  });
}
  }


}
